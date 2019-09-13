

// Id couponID = [Select Id from Coupon__c where Name='Welcome Back' Limit 1].Id;
// SM_Coupon.generateCouponItem(couponID,'0010E00000Voo31QAB');

String offreWelcomeBack = Utils.getUgcGenericParam('Welcome Back Offre Name','033').ParamValue__c;
System.debug(offreWelcomeBack);
Id parentCouponID = [Select Coupon__c from Offre__c where Name = :offreWelcomeBack Limit 1].Coupon__c;
//Id parentCouponID = [Select Id from Coupon__c where Name=:offreWelcomeBack Limit 1].Id;
System.debug(parentCouponID);
Integer validiteCoupon = Integer.valueOf(Utils.getUgcGenericParam('Welcome Back Coupon Validite','033').ParamValue__c);
SM_Coupon.generateCouponItem(parentCouponID,'0010E00000Voo31QAB',Date.today(),Date.today().addMonths(validiteCoupon));

// Select CodePays__c from Account where Id='0010E00000Voo31QAB'

Select CouponWelcomeback__c from Case where Id='5000E000009jMGLQA2'