// delete existing graph
match (n) detach delete n;

// verify you have no nodes/relationships in your graph
match (n) return n;




// Create Employees

CREATE (e1:Employee {name:'Seth Snow', age:'21', phone:'312-566-3234'})
CREATE (e2:Employee {name:'Donny Pollard', age:'32', phone:'312-426-3234'})
CREATE (e3:Employee {name:'Roxie Aguilar', age:'21', phone:'708-322-8712'})
CREATE (e4:Employee {name:'Sonny Horn', age:'27', phone:'630-452-8756'})
CREATE (e5:Employee {name:'Isaac Mendez', age:'19', phone:'312-314-7751'})
CREATE (e6:Employee {name:'Ricky Bond', age:'35', phone:'708-622-8145'})
CREATE (e7:Employee {name:'Don Howe', age:'41', phone:'708-348-3592'})
CREATE (e8:Employee {name:'Carmen Dixon', age:'24', phone:'312-983-3452'})
CREATE (e9:Employee {name:'Steven Carney', age:'19', phone:'312-237-9872'})
CREATE (e10:Employee {name:'Andrea Gallegos', age:'23', phone:'312-862-9866'})
CREATE (e11:Employee {name:'Bryon Ramos', age:'27', phone:'630-876-5429'})
CREATE (e12:Employee {name:'Malik Copeland', age:'38', phone:'312-790-3651'})
CREATE (e13:Employee {name:'Letha Hardy', age:'44', phone:'708-298-3441'})
CREATE (e14:Employee {name:'Denver Glover', age:'27', phone:'312-439-3282'})
CREATE (e15:Employee {name:'Deidre Duke', age:'37', phone:'312-348-7258'})
CREATE (e16:Employee {name:'Lina Rivers', age:'24', phone:'708-827-7761'})
CREATE (e17:Employee {name:'Kraig Hensley', age:'47', phone:'630-628-2771'})
CREATE (e18:Employee {name:'Jerold Mccarthy', age:'49', phone:'312-318-3951'})
CREATE (e19:Employee {name:'Kelvin Haney', age:'25', phone:'708-827-2945'})
CREATE (e20:Employee {name:'Irvin Clayton', age:'32', phone:'708-748-5792'})



// Create Retailers

CREATE (r1:Retailer {name:'Target', street:'240 North Clark', city: 'Chicago', state: 'IL', zip: '60610'})
CREATE (r2:Retailer {name:'Gap', street:'388 East Jackson', city: 'Chicago', state: 'IL', zip: '60612'})
CREATE (r3:Retailer {name:'Walmart', street:'1285 West Harison', city: 'Chicago', state: 'IL', zip: '60617'})
CREATE (r4:Retailer {name:'BestBuy', street:'287 Oakly', city: 'Chicago', state: 'IL', zip: '60615'})
CREATE (r5:Retailer {name:'Express', street:'10 East Erie', city: 'Chicago', state: 'IL', zip: '60615'})
CREATE (r6:Retailer {name:'Nordstrom', street:'45 North LaSalle', city: 'Chicago', state: 'IL', zip: '60616'})
CREATE (r7:Retailer {name:'Kohls', street:'310 East Monroe', city: 'Chicago', state: 'IL', zip: '60620'})
CREATE (r8:Retailer {name:'Neiman Marcus', street:'610 South LaSalle', city: 'Chicago', state: 'IL', zip: '60606'})
CREATE (r9:Retailer {name:'Foot Locker', street:'20 West Randoph St', city: 'Chicago', state: 'IL', zip: '60612'})
CREATE (r10:Retailer {name:'Coach', street:'510 Waker', city: 'Chicago', state: 'IL', zip: '60610'})







// Create WORKS_AT relationship
CREATE (e1)-[:WORKS_AT {job_title:'Sales Associate'}]->(r1)
CREATE (e1)-[:WORKS_AT {job_title:'Stocker'}]->(r2)
CREATE (e2)-[:WORKS_AT {job_title:'Sales Associate'}]->(r3)
CREATE (e3)-[:WORKS_AT {job_title:'Sales Associate'}]->(r4)
CREATE (e3)-[:WORKS_AT {job_title:'Stocker'}]->(r2)
CREATE (e6)-[:WORKS_AT {job_title:'Cashier'}]->(r6)
CREATE (e4)-[:WORKS_AT {job_title:'Cashier'}]->(r4)
CREATE (e5)-[:WORKS_AT {job_title:'Backroom & Receiving'}]->(r4)
CREATE (e6)-[:WORKS_AT {job_title:'Cashier'}]->(r4)
CREATE (e7)-[:WORKS_AT {job_title:'Stocker'}]->(r5)
CREATE (e8)-[:WORKS_AT {job_title:'Stocker'}]->(r6)
CREATE (e8)-[:WORKS_AT {job_title:'Cashier'}]->(r10)
CREATE (e9)-[:WORKS_AT {job_title:'Sales Associate'}]->(r7)
CREATE (e10)-[:WORKS_AT {job_title:'Sales Associate'}]->(r8)
CREATE (e11)-[:WORKS_AT {job_title:'Cashier'}]->(r9)
CREATE (e11)-[:WORKS_AT {job_title:'Cashier'}]->(r10)
CREATE (e12)-[:WORKS_AT {job_title:'Backroom & Receiving'}]->(r10)
CREATE (e13)-[:WORKS_AT {job_title:'Stocker'}]->(r5)
CREATE (e14)-[:WORKS_AT {job_title:'Sales Associate'}]->(r7)
CREATE (e15)-[:WORKS_AT {job_title:'Sales Associate'}]->(r9)
CREATE (e16)-[:WORKS_AT {job_title:'Cashier'}]->(r9)
CREATE (e17)-[:WORKS_AT {job_title:'Backroom & Receiving'}]->(r8)
CREATE (e18)-[:WORKS_AT {job_title:'Cashier'}]->(r10)
CREATE (e19)-[:WORKS_AT {job_title:'Stocker'}]->(r7)
CREATE (e20)-[:WORKS_AT {job_title:'Stocker'}]->(r6)
CREATE (e20)-[:WORKS_AT {job_title:'Sales Associate'}]->(r7)
CREATE (e20)-[:WORKS_AT {job_title:'Cashier'}]->(r5)



// Create Customers
CREATE (c1:Customer {name:'Edgar Haroop', street: '10 West 93rd st', city:'Chicago', state: 'IL', zip: '60615', credit_card:'5500 1000 0000 1004'})
CREATE (c2:Customer {name:' Alex Buel ', street: '4471 Tator Patch Road', city:'Chicago', state: 'IL', zip: '60616', credit_card:'5500 2000 0000 7005'})
CREATE (c3:Customer {name:' Torri Pettway ', street: '1137 Nash Street', city:'Chicago', state: 'IL', zip: '60610', credit_card:'5500 3000 0000 3006'})
CREATE (c4:Customer {name:' Rigoberto Kinchen ', street: '694 Point Street', city:'Chicago', state: 'IL', zip: '60609', credit_card:'5500 4000 0000 4907'})
CREATE (c5:Customer {name:' Cary Mcenaney ', street: '4725 John Calvin Drive', city:'Chicago', state: 'IL', zip: '60605', credit_card:'5500 5000 0000 2808'})
CREATE (c6:Customer {name:' Nicola Castanon ', street: '3681 Oakmound Road', city:'Chicago', state: 'IL', zip: '60618', credit_card:'5500 6000 0000 3109'})
CREATE (c7:Customer {name:' Marceline Westfield ', street: '2795 Vesta Drive', city:'Chicago', state: 'IL', zip: '60620', credit_card:'5500 7000 0000 0105'})
CREATE (c8:Customer {name:' Zenaida Sitzes ', street: '1274 Poplar Street', city:'Chicago', state: 'IL', zip: '60601', credit_card:'5500 8000 0000 5905'})
CREATE (c9:Customer {name:' Aura Schiel ', street: '3781 Oakmound Road', city:'Chicago', state: 'IL', zip: '60603', credit_card:'5500 9000 0000 8705'})
CREATE (c10:Customer {name:' Corinne Suman ', street: '4355 Virginia Street', city:'Chicago', state: 'IL', zip: '60624', credit_card:'5500 0100 0000 0025'})
CREATE (c11:Customer {name:'Jonathan Rinka', street: '1114 Oakmound Drive', city:'Chicago', state: 'IL', zip: '60640', credit_card:'5500 0100 0000 8805'})
CREATE (c12:Customer {name:'Richard Smith', street: '3830 Cherry Camp Road', city:'Chicago', state: 'IL', zip: '60643', credit_card:'5500 0200 0000 4905'})
CREATE (c13:Customer {name:'Sarah Radovic', street: '234 East 55th st', city:'Chicago', state: 'IL', zip: '60615', credit_card:'5500 0300 0000 1805'})
CREATE (c14:Customer {name:'Lucy Scheller', street: '520 North wells st', city:'Chicago', state: 'IL', zip: '60610', credit_card:'5500 0400 0000 4205'})
CREATE (c15:Customer {name:'Carol Rose', street: '320 Virginia Street', city:'Chicago', state: 'IL', zip: '60610', credit_card:'5500 0400 0000 2976'})
CREATE (c16:Customer {name:'Lacy Grant', street: '180 Vesta Drive', city:'Chicago', state: 'IL', zip: '60610', credit_card:'5500 0400 0000 6721'})
CREATE (c17:Customer {name:'Ashlee Reid', street: '360 Taylor st', city:'Chicago', state: 'IL', zip: '60610', credit_card:'5500 0400 0000 8923'})
CREATE (c18:Customer {name:'Sallie Bauer', street: '430 Cherry Camp Road', city:'Chicago', state: 'IL', zip: '60610', credit_card:'5500 0400 0000 7823'})
CREATE (c19:Customer {name:'Wade Boyer', street: '180 Nash Street', city:'Chicago', state: 'IL', zip: '60610', credit_card:'5500 0400 0000 8938'})
CREATE (c20:Customer {name:'Larry Grahamr', street: '301  Oakmound Road', city:'Chicago', state: 'IL', zip: '60610', credit_card:'5500 0400 0000 6182'})

// Create Online Customer Accounts

CREATE (a1:Account {login_id: 'abc123',  last_date_received_delivery_notification: '1/14/2020'})
CREATE (a2:Account {login_id: 'abc124', last_date_received_delivery_notification: '3/15/2020'})
CREATE (a3:Account {login_id: 'abc125', last_date_received_delivery_notification: '1/22/2020'})
CREATE (a4:Account {login_id: 'abc126', last_date_received_delivery_notification: '4/17/2020'})
CREATE (a5:Account {login_id: 'abc127', last_date_received_delivery_notification: '2/21/2020'})
CREATE (a6:Account {login_id: 'xyz123', last_date_received_delivery_notification: '2/17/2020'})
CREATE (a7:Account {login_id: 'xyz124', last_date_received_delivery_notification: '3/24/2020'})
CREATE (a8:Account {login_id: 'xyz125', last_date_received_delivery_notification: '5/21/2020'})
CREATE (a9:Account {login_id: 'xyz126', last_date_received_delivery_notification: '2/19/2020'})
CREATE (a10:Account {login_id: 'xyz127', last_date_received_delivery_notification: '4/21/2020'})


// Create USED Accounts Relationship 
CREATE (c11)-[:USES_ACCOUNT {last_date_accessed:'1/12/2020'}]->(a1)
CREATE (c12)-[:USES_ACCOUNT {last_date_accessed:'3/10/2020'}]->(a2)
CREATE (c13)-[:USES_ACCOUNT {last_date_accessed:'1/17/2020'}]->(a3)
CREATE (c14)-[:USES_ACCOUNT {last_date_accessed:'4/12/2020'}]->(a1)
CREATE (c14)-[:USES_ACCOUNT {last_date_accessed:'4/15/2020'}]->(a4)
CREATE (c9)-[:USES_ACCOUNT {last_date_accessed:'2/19/2020'}]->(a5)
CREATE (c8)-[:USES_ACCOUNT {last_date_accessed:'2/14/2020'}]->(a6)
CREATE (c4)-[:USES_ACCOUNT {last_date_accessed:'2/18/2020'}]->(a6)
CREATE (c7)-[:USES_ACCOUNT {last_date_accessed:'3/19/2020'}]->(a7)
CREATE (c4)-[:USES_ACCOUNT {last_date_accessed:'5/18/2020'}]->(a8)
CREATE (c3)-[:USES_ACCOUNT {last_date_accessed:'2/13/2020'}]->(a9)
CREATE (c1)-[:USES_ACCOUNT {last_date_accessed:'4/17/2020'}]->(a10)





// Create Transactions
CREATE (c1)-[:SHOPPED_AT {amount:'986', date:'4/17/2020', status:'Approved'}]->(r6)
CREATE (c1)-[:SHOPPED_AT {amount:'239', date:'5/15/2020', status:'Approved'}]->(r1)
CREATE (c1)-[:SHOPPED_AT {amount:'475', date:'3/28/2020', status:'Approved'}]->(r8)
CREATE (c1)-[:SHOPPED_AT {amount:'654', date:'3/20/2020', status:'Disputed'}]->(r3)
CREATE (c2)-[:SHOPPED_AT {amount:'196', date:'2/24/2020', status:'Approved'}]->(r9)
CREATE (c2)-[:SHOPPED_AT {amount:'502', date:'4/9/2020', status:'Approved'}]->(r2)
CREATE (c2)-[:SHOPPED_AT {amount:'848', date:'5/29/2020', status:'Approved'}]->(r3)
CREATE (c2)-[:SHOPPED_AT {amount:'802', date:'3/11/2020', status:'Approved'}]->(r1)
CREATE (c2)-[:SHOPPED_AT {amount:'203', date:'3/27/2020', status:'Approved'}]->(r2)
CREATE (c3)-[:SHOPPED_AT {amount:'35', date:'1/23/2020', status:'Approved'}]->(r1)
CREATE (c3)-[:SHOPPED_AT {amount:'605', date:'1/27/2020', status:'Disputed'}]->(r1)
CREATE (c3)-[:SHOPPED_AT {amount:'62', date:'4/17/2020', status:'Disputed'}]->(r9)
CREATE (c3)-[:SHOPPED_AT {amount:'141', date:'11/14/2020', status:'Approved'}]->(r1)
CREATE (c4)-[:SHOPPED_AT {amount:'134', date:'4/14/2020', status:'Approved'}]->(r5)
CREATE (c4)-[:SHOPPED_AT {amount:'336', date:'4/3/2020', status:'Approved'}]->(r5)
CREATE (c4)-[:SHOPPED_AT {amount:'964', date:'3/22/2020', status:'Approved'}]->(r3)
CREATE (c4)-[:SHOPPED_AT {amount:'430', date:'5/10/2020', status:'Approved'}]->(r8)
CREATE (c4)-[:SHOPPED_AT {amount:'11', date:'9/4/2020', status:'Approved'}]->(r9)
CREATE (c5)-[:SHOPPED_AT {amount:'545', date:'1/6/2020', status:'Approved'}]->(r9)
CREATE (c5)-[:SHOPPED_AT {amount:'457', date:'1/15/2020', status:'Approved'}]->(r10)
CREATE (c5)-[:SHOPPED_AT {amount:'468', date:'2/29/2020', status:'Disputed'}]->(r7)
CREATE (c5)-[:SHOPPED_AT {amount:'768', date:'1/28/2020', status:'Approved'}]->(r5)
CREATE (c5)-[:SHOPPED_AT {amount:'921', date:'3/12/2020', status:'Approved'}]->(r6)
CREATE (c6)-[:SHOPPED_AT {amount:'740', date:'1/15/2020', status:'Approved'}]->(r4)
CREATE (c6)-[:SHOPPED_AT {amount:'510', date:'1/27/2020', status:'Approved'}]->(r2)
CREATE (c6)-[:SHOPPED_AT {amount:'414', date:'1/20/2020', status:'Approved'}]->(r6)
CREATE (c6)-[:SHOPPED_AT {amount:'721', date:'7/17/2020', status:'Disputed'}]->(r10)
CREATE (c6)-[:SHOPPED_AT {amount:'353', date:'1/25/2020', status:'Approved'}]->(r4)
CREATE (c7)-[:SHOPPED_AT {amount:'681', date:'2/28/2020', status:'Approved'}]->(r8)
CREATE (c7)-[:SHOPPED_AT {amount:'87', date:'2/19/2020', status:'Approved'}]->(r3)
CREATE (c7)-[:SHOPPED_AT {amount:'533', date:'5/6/2020', status:'Disputed'}]->(r5)
CREATE (c7)-[:SHOPPED_AT {amount:'723', date:'1/8/2020', status:'Approved'}]->(r5)
CREATE (c7)-[:SHOPPED_AT {amount:'627', date:'5/20/2020', status:'Approved'}]->(r6)
CREATE (c8)-[:SHOPPED_AT {amount:'74', date:'3/4/2020', status:'Approved'}]->(r9)
CREATE (c8)-[:SHOPPED_AT {amount:'231', date:'5/12/2020', status:'Approved'}]->(r3)
CREATE (c8)-[:SHOPPED_AT {amount:'924', date:'1/4/2020', status:'Approved'}]->(r9)
CREATE (c8)-[:SHOPPED_AT {amount:'742', date:'6/12/2020', status:'Approved'}]->(r6)
CREATE (c9)-[:SHOPPED_AT {amount:'276', date:'2/24/2020', status:'Approved'}]->(r9)
CREATE (c9)-[:SHOPPED_AT {amount:'66', date:'4/16/2020', status:'Approved'}]->(r5)
CREATE (c9)-[:SHOPPED_AT {amount:'467', date:'2/23/2020', status:'Approved'}]->(r3)
CREATE (c9)-[:SHOPPED_AT {amount:'830', date:'3/13/2020', status:'Disputed'}]->(r8)
CREATE (c9)-[:SHOPPED_AT {amount:'240', date:'4/9/2020', status:'Approved'}]->(r1)
CREATE (c9)-[:SHOPPED_AT {amount:'164', date:'2/26/2020', status:'Approved'}]->(r9)
CREATE (c10)-[:SHOPPED_AT {amount:'630', date:'1/6/2020', status:'Approved'}]->(r8)
CREATE (c10)-[:SHOPPED_AT {amount:'19', date:'3/29/2020', status:'Approved'}]->(r2)
CREATE (c10)-[:SHOPPED_AT {amount:'352', date:'2/16/2020', status:'Approved'}]->(r7)
CREATE (c10)-[:SHOPPED_AT {amount:'147', date:'4/3/2020', status:'Approved'}]->(r8)
CREATE (c10)-[:SHOPPED_AT {amount:'91', date:'5/29/2020', status:'Approved'}]->(r10)
CREATE (c1)-[:SHOPPED_AT {amount:'1021', date:'5/23/2020', status:'Disputed'}]->(r7)
CREATE (c1)-[:SHOPPED_AT {amount:'1732', date:'5/26/2020', status:'Disputed'}]->(r8)
CREATE (c1)-[:SHOPPED_AT {amount:'1415', date:'4/1/2020', status:'Disputed'}]->(r6)
CREATE (c1)-[:SHOPPED_AT {amount:'1849', date:'2/20/2020', status:'Disputed'}]->(r3)
CREATE (c4)-[:SHOPPED_AT {amount:'914', date:'3/18/2020', status:'Disputed'}]->(r3)
CREATE (c4)-[:SHOPPED_AT {amount:'424', date:'5/10/2020', status:'Disputed'}]->(r4)
CREATE (c4)-[:SHOPPED_AT {amount:'721', date:'4/1/2020', status:'Disputed'}]->(r5)
CREATE (c4)-[:SHOPPED_AT {amount:'1003', date:'2/20/2020', status:'Disputed'}]->(r6)
CREATE (c8)-[:SHOPPED_AT {amount:'1149', date:'3/18/2020', status:'Disputed'}]->(r3)
CREATE (c8)-[:SHOPPED_AT {amount:'378', date:'2/10/2020', status:'Disputed'}]->(r4)
CREATE (c8)-[:SHOPPED_AT {amount:'1884', date:'5/7/2020', status:'Disputed'}]->(r5)
CREATE (c8)-[:SHOPPED_AT {amount:'1790', date:'1/20/2020', status:'Disputed'}]->(r6)
CREATE (c10)-[:SHOPPED_AT {amount:'925', date:'4/18/2020', status:'Approved'}]->(r3)
CREATE (c10)-[:SHOPPED_AT {amount:'374', date:'2/10/2020', status:'Approved'}]->(r4)
CREATE (c10)-[:SHOPPED_AT {amount:'368', date:'5/3/2020', status:'Approved'}]->(r5)
CREATE (c10)-[:SHOPPED_AT {amount:'816', date:'2/20/2020', status:'Disputed'}]->(r6)
CREATE (c11)-[:SHOPPED_AT {amount:'945', date:'1/27/2020', status:'Disputed'}]->(r3)
CREATE (c11)-[:SHOPPED_AT {amount:'1345', date:'2/18/2020', status:'Disputed'}]->(r7)
CREATE (c11)-[:SHOPPED_AT {amount:'375', date:'4/19/2020', status:'Disputed'}]->(r8)
CREATE (c12)-[:SHOPPED_AT {amount:'1145', date:'3/18/2020', status:'Disputed'}]->(r10)
CREATE (c12)-[:SHOPPED_AT {amount:'875', date:'5/13/2020', status:'Disputed'}]->(r7)
CREATE (c12)-[:SHOPPED_AT {amount:'265', date:'6/27/2020', status:'Approved'}]->(r8)
CREATE (c13)-[:SHOPPED_AT {amount:'516', date:'3/15/2020', status:'Disputed'}]->(r6)
CREATE (c14)-[:SHOPPED_AT {amount:'424', date:'5/20/2020', status:'Disputed'}]->(r4)
CREATE (c14)-[:SHOPPED_AT {amount:'424', date:'5/20/2020', status:'Approved'}]->(r5)
CREATE (c14)-[:SHOPPED_AT {amount:'424', date:'5/20/2020', status:'Approved'}]->(r6)
CREATE (c15)-[:SHOPPED_AT {amount:'721', date:'4/13/2020', status:'Disputed'}]->(r5)
CREATE (c16)-[:SHOPPED_AT {amount:'1003', date:'2/20/2020', status:'Disputed'}]->(r6)
CREATE (c17)-[:SHOPPED_AT {amount:'1149', date:'3/18/2020', status:'Disputed'}]->(r3)
CREATE (c18)-[:SHOPPED_AT {amount:'378', date:'2/10/2020', status:'Disputed'}]->(r9)
CREATE (c19)-[:SHOPPED_AT {amount:'1884', date:'3/19/2020', status:'Approved'}]->(r5)
CREATE (c20)-[:SHOPPED_AT {amount:'324', date:'1/28/2020', status:'Approved'}]->(r8)
CREATE (c20)-[:SHOPPED_AT {amount:'425', date:'5/19/2020', status:'Disputed'}]->(r3)
CREATE (c17)-[:SHOPPED_AT {amount:'613', date:'3/27/2020', status:'Approved'}]->(r3)
CREATE (c18)-[:SHOPPED_AT {amount:'343', date:'4/18/2020', status:'Approved'}]->(r7)
CREATE (c20)-[:SHOPPED_AT {amount:'475', date:'5/19/2020', status:'Disputed'}]->(r8)



// Create Memberships history
CREATE (c1)-[:HAS_MEMBERSHIP_AT {reward_points:'5300', member_since:'5/1/2020'}]->(r1)
CREATE (c1)-[:HAS_MEMBERSHIP_AT {reward_points:'3300', member_since:'5/1/2019'}]->(r7)
CREATE (c2)-[:HAS_MEMBERSHIP_AT {reward_points:'3200', member_since:'3/1/2013'}]->(r5)
CREATE (c3)-[:HAS_MEMBERSHIP_AT {reward_points:'2400', member_since:'8/1/2012'}]->(r6)
CREATE (c7)-[:HAS_MEMBERSHIP_AT {reward_points:'4200', member_since:'7/1/2015'}]->(r3)
CREATE (c10)-[:HAS_MEMBERSHIP_AT {reward_points:'300', member_since:'5/1/2020'}]->(r4)
CREATE (c11)-[:HAS_MEMBERSHIP_AT {reward_points:'700', member_since:'3/1/2013'}]->(r8)
CREATE (c14)-[:HAS_MEMBERSHIP_AT {reward_points:'4100', member_since:'5/1/2018'}]->(r1)
CREATE (c15)-[:HAS_MEMBERSHIP_AT {reward_points:'3200', member_since:'3/1/2013'}]->(r5)
CREATE (c16)-[:HAS_MEMBERSHIP_AT {reward_points:'2400', member_since:'8/1/2012'}]->(r6)
CREATE (c17)-[:HAS_MEMBERSHIP_AT {reward_points:'3200', member_since:'7/1/2015'}]->(r3)
CREATE (c18)-[:HAS_MEMBERSHIP_AT {reward_points:'300', member_since:'5/1/2016'}]->(r7)
CREATE (c19)-[:HAS_MEMBERSHIP_AT {reward_points:'500', member_since:'3/1/2017'}]->(r4)


RETURN *


