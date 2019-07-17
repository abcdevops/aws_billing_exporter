[![CircleCI](https://circleci.com/gh/abcdevops/aws_billing_exporter.svg?style=svg)](https://circleci.com/gh/abcdevops/aws_billing_exporter)
[![Docker Pulls](https://img.shields.io/docker/pulls/abcdevops/aws-billing-exporter.svg?maxAge=604800)](https://hub.docker.com/r/abcdevops/aws-billing-exporter)

AWS Billing exporter using cost and explorer API for prometheus
--

To run it, create AWS secret key, access key and region environment varialbes.

```bash
aws_billing_exporter [flags]
```

## Exported Metrics

|Metric No | Metric Name | Meaning | Labels |
| -------- | ------ | ------- | ------ |
| 1 | amortized_cost | This cost metric reflects the effective cost of the upfront and monthly reservation fees spread across the billing period. | type, unit |
| 2 | blended_cost | This cost metric reflects the average cost of usage across the consolidated billing family. | type, unit |
| 3 | net_amortized_cost | This cost metric amortizes the upfront and monthly reservation fees while including discounts such as RI volume discounts. | type, unit |
| 4 | net_unblended_cost | This cost metric reflects the cost after discounts. | type, unit |
| 5 | normalized_usage_amount | Cost of amount of resource consumption like CPU. | type, unit |
| 6 | unblended_cost | Unblended costs separate discounts into their own line items. This enables you to view the amount of each discount received. | type, unit |
| 7 | usage_quantity | Usage of quantity like data in GB.  | type, unit |

### Flags

```bash
./aws_billing_exporter --help
```

* __`web.listen-address`:__ Address to listen on for web interface and telemetry. Default port is 9614.
* __`web.telemetry-path`:__ Path under which to expose metrics. Default is "/metrics"
* __`aws-billing.metrics`:__ Comma-separated list of billing metrics. Leave this argument if you want to scrape all available metrics. e.g for blended cost and usage quantity it should have "2,7"
* __`log.level`:__ Logging level. `info` by default.
* __`version`:__ Show application version.


### Usage

Your aws credentials should either be in $HOME/.aws/credentials , or set via AWS_ACCESS_KEY and AWS_SECRET_ACCESS_KEY. It will also respect ec2 instances having corresponding role with the required permission to access cost and explorer API.

It will only fetch metrics from AWS when somebody will access <domain>:9614/metrics. So no periodic calls. 

Following will start pulling BlendedCost aws cost metric from your AWS account

```bash
export AWS_ACCESS_KEY=<your aws key>
export AWS_SECRET_ACCESS_KEY=<your aws secret key>
export AWS_REGION=<aws region>
aws_billing_exporter --aws-billing.metrics="2"
```

### Permission policy

You have to add inline policy for your AWS account. Following is the the json object for required permission to access cost and explorer API.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ce:*",
            "Resource": "*"
        }
    ]
}
```