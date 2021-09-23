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

#### Scenario

In the **step 1** _script_ sends request to create passive buy order by user _DEMO-CONN1_.
Order has next parameters:
- Size (_OrderQty_) = 30
- Price = 55 (_x_ | _x_ depends on instrument)

To the end of the **step 1** response message about successfully created order is expected.

In the **step 2** _script_ sends instructions for checking response to the _check1_.

To the end of the **step 2** response be successfully checked by sent instructions is expected.

#### Actual work

First image contains events within steps 1 and 2 from th2 reports.

Second image is the modified flow diagram with marks of creating events.

![](images/steps-1-2-report.png)

_"Received 'ExecutionReport' response message"_ in **step 1** is an expected output.

Green _"Check messages"_ in **step 2** is an expected output.

![](images/Demo_script_flow-Step1-2.drawio.png)


There is a possibility to check messages details. It can be very useful.  
For example, details of  _ExecutionReport_ from **step 1**.
Fields _Price_, _OrderQty_ (Size), _Text_ (Comment) can be found here.

![](images/step1-exec-report-details.png)

_Text_ contains information that this report is about placing order.


### STEPS 3, 4

#### Scenario

In the **step 3** _script_ sends request to create passive buy order by user _DEMO-CONN1_.
Order has next parameters:
- Size (_OrderQty_) = 10
- Price = 56 (_x+1_ | _x_ depends on instrument)

To the end of the **step 3** response message about successfully created order is expected.

In the **step 4** _script_ sends instructions for checking response to the _check1_.

To the end of the **step 4** response be successfully checked by sent instructions is expected.

#### Actual work

First image contains events within steps 3 and 4 from th2 reports.

Second image is the modified flow diagram with marks of creating events.

![](images/steps-3-4-report.png)

_"Received 'ExecutionReport' response message"_ in **step 3** is an expected output.

Green _"Check messages"_ in **step 4** is an expected output.

![](images/Demo_script_flow-Step3-4.drawio.png)

### STEPS 5, 6, 7

#### Scenario

In the **step 5** _script_ sends request to create aggressive sell IOC order by user _DEMO-CONN2_.
Order has next parameters:
- Size (_OrderQty_) = 100
- Price = 54 (_x-1_ | _x_ depends on instrument)

To the end of the **step 5** response message about successfully trades or cancelling order, because IOC
cannot be just placed.

There are **2 buy orders** with overall size (30 + 10) not bigger 
than size of the **sell order** (100). Prices of these **buy orders** (55 and 56) are bigger
than price of the **sell order** (54). So trades are happening.

In the **step 6** _script_ sends instructions for checking 
response messages for user _DEMO-CONN1_ to the _check1_.
_DEMO-CONN1_ awaits messages about buying by 2 orders, so there should be only 2 messages.

To the end of the **step 6** response be successfully checked 
**2** messages by sent instructions is expected.

In the **step 7** _script_ sends instructions for checking
response messages for user _DEMO-CONN2_ to the _check1_.
_DEMO-CONN2_ should receive 3 messages:
1. Trade with _DEMO-CONN1_ for Order with Size=30
2. Trade with _DEMO-CONN1_ for Order with Size=10
3. Cancelling not traded Size (100 - 30 - 10 = 60)

To the end of the **step 7** response be successfully checked
**3** messages by sent instructions is expected.

#### Actual work

First image contains events within steps 5, 6 and 7 from th2 reports.

Second image is the modified flow diagram with marks of creating events.

![](images/steps-5-6-7-report.png)

![](images/Demo_script_flow-Step5-6-7.drawio.png)

## Searching exceptions
th2 is the **test** tool. So it should be able to catch exceptions. 

To demonstrate this ability _simulator box_ was programmed to create 
exceptions with the specific instruments from the _script_.

_INSTR1_, _INSTR2_, _INSTR3_ work normally. Exceptions from other 
instruments will be described below.

## Compare results

{{< youtube mQa8c-OZZhU >}} 
