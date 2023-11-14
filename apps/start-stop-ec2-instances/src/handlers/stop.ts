import { ScheduledHandler } from "aws-lambda";
import { EC2 } from "aws-sdk";
import axios from "axios";

export const handler: ScheduledHandler = async (event) => {
  const ec2 = new EC2({ region: event.region });

  const instanceId = process.env.EC2_INSTANCE_ID;

  if (!instanceId) {
    throw new Error("EC2_INSTANCE_ID is not defined");
  }

  // check if instance is running. If yes, stop it
  const instanceStatus = await ec2
    .describeInstanceStatus({
      InstanceIds: [instanceId],
    })
    .promise();

  if (
    instanceStatus?.InstanceStatuses?.length === 0 ||
    (instanceStatus?.InstanceStatuses &&
      instanceStatus?.InstanceStatuses[0].InstanceState?.Name !== "running")
  ) {
    console.log("Instance is not running. Nothing to do");
    return;
  }

  const result = await ec2
    .stopInstances({ InstanceIds: [instanceId] })
    .promise();
  if (result.$response.error) {
    throw result.$response.error;
  }

  console.log("Instance stopped");

  // send it to Slack
  const slackWebhookUrl = process.env.SLACK_WEBHOOK_URL;
  const messagePrefix = process.env.SLACK_MESSAGE_PREFIX || "";

  if (!slackWebhookUrl) {
    console.warn("SLACK_WEBHOOK_URL is not defined");
    return;
  }

  // use fetch to send a POST request to Slack webhook
  await axios.post(slackWebhookUrl, {
    text: `${messagePrefix} Instance stopped`,
  });

  console.log("Slack message sent");
};
