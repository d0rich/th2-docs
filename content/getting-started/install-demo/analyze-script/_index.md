---
title: Demo script analysis
weight: 35
pre: "<b>1.3.7 </b>"
chapter: false
---
## Demo script scenario
1. User1 submit passive buy order with **Price=x** and **Size=30** - **Order1**
2. User1 receives an Execution Report with **ExecType=0**
3. User1 submit passive buy order with **Price=x+1** and **Size=10** - **Order2**
4. User1 receives an Execution Report with **ExecType=0**
5. User2 submit an aggressive sell IOC (Immediate Or Cancel) order with **price=x-1** and **Size=100** - **Order3**  
   1. User1 receives an Execution Report with **ExecType=F** on trade between **Order2** and **Order3**
   2. User2 receives an Execution Report with **ExecType=F** on trade between **Order3** and **Order2**
   3. User1 receives an Execution Report with **ExecType=F** on trade between **Order1** and **Order3**
   4. User2 receives an Execution Report with **ExecType=F** on trade between **Order3** and **Order1**
   5. User2 receives an Execution Report with **ExecType=C** on expired **Order3**

## Boxes in schema

At step 3 th2-infra-schema was installed.  
Boxes created by th2-infra-schema for demo version are described there.
![Environment schema](https://github.com/th2-net/th2-infra-schema-demo/blob/master/schema-ver-154.png?raw=true "Environment schema") 

Demo script uses next boxes:
1. **script** - there demo script is running;
2. **act fix** can initiate FIX message sending;
3. **check1** is needed for data comparison;
4. **codec fix** encrypts and decrypts messages on the client side;
5. **conn client fix** (connectivity client FIX) sends and receives FIX messages on the client side;
6. **conn server fix** (connectivity server FIX) sends and receives FIX messages on the server side;
7. **conn server dc** (connectivity server Drop Copy) replicates FIX messages for one or more participants;
8. **conn dc fix** (connectivity Drop Copy FIX) needed for receiving replicated FIX messages;
9. **codec sim fix** encrypts and decrypts messages on the server side;
10. **sim** (simulation) simulate server activity;
11. **estore** - store for events;
12. **mstore** - store for messages.

## Demo script flow

In this example, **flow** is the path of the one message sent by the _script_.

![Demo script flow animation](https://github.com/th2-net/th2-documentation/raw/master/images/demo-ver154-main/script_flow.gif)

In the diagram below flow is described in static way.

![Demo script flow](images/Demo_script_flow-separated_conns.drawio.png)

## th2 reports

There is a web application that can display reports about th2 work.

It can be reached with the URI _http://\<hostname\>:30000/\<schema-namespace\>/_

![th2 reports GUI](images/th2-reports.png)

## Demo script steps

Demo script runs 6 times - with 6 different instruments.

![](images/6-runs.png)

Each run except 6th has 7 steps inside.

![](images/7-steps-in-run.png)

First run will be commented there.

### STEPS 1, 2

First image contains events within steps 1 and 2 from th2 reports.

Second image is the modified flow diagram with marks of creating events.

![](images/steps-1-2-report.png)

![](images/Demo_script_flow-Step1-2.drawio.png)

### STEPS 3, 4

### STEPS 5, 6, 7

## Compare results

{{< youtube mQa8c-OZZhU >}} 
