import {
  DescribeInstancesCommand,
  DescribeInstanceStatusCommand,
  EC2Client,
  StartInstancesCommand,
  waitUntilInstanceRunning,
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

  // check if instance is running. If not, start it
  const instanceStatus = await ec2.send(
    new DescribeInstanceStatusCommand({
      InstanceIds: [instanceId],
    })
  );

  if (instanceStatus?.InstanceStatuses?.[0]?.InstanceState?.Name === "running") {
    console.log("Instance is already running");
    return;
  }

  // SDK v3 throws on API errors, no $response envelope to inspect
  await ec2.send(new StartInstancesCommand({ InstanceIds: [instanceId] }));
  console.log("Instance started");

  // wait for instance to be running
  await waitUntilInstanceRunning(
    { client: ec2, maxWaitTime: 300 },
    { InstanceIds: [instanceId] }
  );
  console.log("Instance is running");

  // get instance public ip
  const instance = await ec2.send(
    new DescribeInstancesCommand({ InstanceIds: [instanceId] })
  );
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

  // use axios to send a POST request to Slack webhook
  await axios.post(slackWebhookUrl, {
    text: `${messagePrefix} Instance started. Public IP: ${publicIp}`,
  });

  console.log("Slack message sent");
};
