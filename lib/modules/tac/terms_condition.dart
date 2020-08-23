import 'dart:ui';

import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';

class TearmsAndConditions extends StatefulWidget {
  @override
  _TearmsAndConditionsState createState() => _TearmsAndConditionsState();
}

  String firstpara = "By installing the App, you are agreeing to the terms of this Agreement between you and WHERETO.  By using the Platform you agree to adhere to all the guidelines, policies, terms and conditions described in this Agreement.  This Agreement is legally binding.  If you do not agree to these guidelines, policies, terms and conditions then you must not use the Platform.We collect information in accordance with our Privacy Policy which is considered an integral part of this Agreement.  By agreeing to this Agreement you are acknowledging our Privacy Policy and consenting to our privacy practices as described therein.  You may review WHERRTO's Privacy Policy that is set forth here.";
  String oneterm ="1. Permission to Use the Site.  Subject to your acceptance and continue adherence to the terms and conditions of this Agreement, you are hereby granted a limited permission (i) to access and use the Site through compatible browser software, and (ii) to use, perform, and display the App on a compatible mobile computing device (e.g., an iPhone) that you own or control (your "'Mobile Device'"), in all cases solely to submit Delivery Orders in accordance with this Agreement.";
  String secondTerm = "2. Usage Restrictions. You may not use, copy, modify or transfer the Platform or any component of the Platform, in whole or in part.  You may not reverse engineer, disassemble, decompile, or translate the Platform, attempt to derive the source code of any software comprising the Platform, create any derivative work from the Platform, or authorize any third party to do any of the foregoing.  Any attempt to transfer any of the rights, duties or obligations under this Agreement is void.  You may not rent, lease, loan, resell for profit, or distribute the Platform, or any part thereof, nor may you provide access to the Platform for third parties in the nature of a service bureau or application services provider.  You may not remove or alter any proprietary notice or legend in the Platform.  You may not use the Platform except in accordance with applicable laws and regulations.";
  String thirdTerm = "3.  Ownership of Intellectual Property Rights. The App is licensed to you, not sold, and you are only permitted to use the Site for the sole purpose of submitting Delivery Orders.  You acknowledge that WHERETO and its licensors own and retain all proprietary rights in the Platform (including all Upgrades thereto).  The Platform includes copyrighted material, trademarks, and other proprietary information ("'Intellectual Property'") of WHERETO, and its licensors.  There are no implied licenses under this Agreement, and all rights not expressly granted are hereby reserved.  You agree that any questions, comments, or suggestions (collectively, "'Feedback'") that you send to us shall become the sole property of WHERETO. You further agree that WHERETO shall be free to use and exploit in any manner any ideas, concepts, know-how, methods, or techniques contained in such Feedback for any purpose without your consent and without payment of any consideration to you, you hereby assign all rights, title and interest in such Feedback to WHERETO.This Agreement may contain certain supplemental terms, that are located below.  In the event of a conflict between the terms located below and the terms provided above, the terms provided above shall always supersede and govern.";


class _TearmsAndConditionsState extends State<TearmsAndConditions> {
  @override
  Widget build(BuildContext context) {
     return BackdropFilter(
       filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
       child: Dialog(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
         ),
           elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          height: 500,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
          color: Colors.white,),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 30,right: 30,top: 15),
              child: Column(
                children: <Widget>[
                  Text("TERMS OF AGREEMENT",
                  maxLines: 20,
                  style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 25
                  ),
                  ),
                  SizedBox(height: 10,),
                  Text(firstpara,
                  maxLines: 50,
                  style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-light',
                    fontSize: 12
                  ),
                  ),
                  SizedBox(height: 25,),
                  Text(oneterm,
                  maxLines: 90,
                  style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-light',
                    fontSize: 12
                  ),
                  ),
                  SizedBox(height: 25,),
                  Text(secondTerm,
                  maxLines: 90,
                  style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-light',
                    fontSize: 12
                  ),
                  ),
                  SizedBox(height: 25,),
                  Text(thirdTerm,
                  maxLines: 90,
                  style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-light',
                    fontSize: 12
                  ),
                  ),
                  SizedBox(height: 25,),
                 
                ],
              ),
            ),
          ),
        ),
       ),
     );
  }


}