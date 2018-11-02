#!/bin/bash

while sleep 10; 
do
  aws cloudwatch put-metric-data --namespace MyCustomMetric --metric-data MetricName=SomeValue,Value=2
done
