import {
  DescribeInstanceStatusCommand,
  EC2Client,
  StopInstancesCommand,
} from "@aws-sdk/client-ec2";
import { ScheduledHandler } from "aws-lambda";
import axios from "axios";

export const handler: ScheduledHandler = async (event) => {
  const instanceId = process.env.EC2_INSTANCE_ID;

  if (!instanceId) {
    throw new Error("EC2_INSTANCE_ID is not defined");
  }

  const ec2 = new EC2Client({
    region: (event as { region?: string }).region,
  });

  // check if instance is running. If yes, stop it
  const instanceStatus = await ec2.send(
    new DescribeInstanceStatusCommand({
      InstanceIds: [instanceId],
    })
  );

  if (
    instanceStatus?.InstanceStatuses?.length === 0 ||
    (instanceStatus?.InstanceStatuses &&
      instanceStatus?.InstanceStatuses[0].InstanceState?.Name !== "running")
  ) {
    console.log("Instance is not running. Nothing to do");
    return;
  }

  // SDK v3 throws on API errors, no $response envelope to inspect
  await ec2.send(new StopInstancesCommand({ InstanceIds: [instanceId] }));
  console.log("Instance stopped");

  // send it to Slack
  const slackWebhookUrl = process.env.SLACK_WEBHOOK_URL;
  const messagePrefix = process.env.SLACK_MESSAGE_PREFIX || "";

  if (!slackWebhookUrl) {
    console.warn("SLACK_WEBHOOK_URL is not defined");
    return;
  }

  // use axios to send a POST request to Slack webhook
  await axios.post(slackWebhookUrl, {
    text: `${messagePrefix} Instance stopped`,
  });

  console.log("Slack message sent");
};
