import { ScheduledHandler } from "aws-lambda";
import { EC2 } from "aws-sdk";
import axios from "axios";
import fetch from "node-fetch";

export const handler: ScheduledHandler = async (event) => {
  const ec2 = new EC2({ region: event.region });

  const instanceId = process.env.EC2_INSTANCE_ID;

  if (!instanceId) {
    throw new Error("EC2_INSTANCE_ID is not defined");
  }

  // check if instance is running. If not, start it
  const instanceStatus = await ec2
    .describeInstanceStatus({
      InstanceIds: [instanceId],
    })
    .promise();

  if (
    instanceStatus?.InstanceStatuses &&
    instanceStatus?.InstanceStatuses[0]?.InstanceState?.Name === "running"
  ) {
    console.log("Instance is already running");
    return;
  }

  const result = await ec2
    .startInstances({ InstanceIds: [instanceId] })
    .promise();
  if (result.$response.error) {
    throw result.$response.error;
  }

  console.log("Instance started");

  // wait for instance to be running
  await ec2.waitFor("instanceRunning", { InstanceIds: [instanceId] }).promise();
  console.log("Instance is running");

  // get instance public ip
  const instance = await ec2
    .describeInstances({ InstanceIds: [instanceId] })
    .promise();
  const publicIp = instance?.Reservations?.[0]?.Instances?.[0]?.PublicIpAddress;

  if (!publicIp) {
    console.warn("Instance public IP is not defined");
    return;
  }

  console.log(`Instance public IP: ${publicIp}`);

  // send it to Slack
  const slackWebhookUrl = process.env.SLACK_WEBHOOK_URL;
  const messagePrefix = process.env.SLACK_MESSAGE_PREFIX || "";

  if (!slackWebhookUrl) {
    console.warn("SLACK_WEBHOOK_URL is not defined");
    return;
  }

  // use fetch to send a POST request to Slack webhook
  await axios.post(slackWebhookUrl, {
    text: `${messagePrefix} Instance started. Public IP: ${publicIp}`,
  });

  console.log("Slack message sent");
};
