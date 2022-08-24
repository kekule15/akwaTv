import 'package:akwatv/styles/appColors.dart';
import 'package:akwatv/views/home/settings/widgets/terms_conditions_text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class TermsAndConditions extends ConsumerWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.black,
        centerTitle: true,
        title: Text(
          'termsAndCondition'.tr,
          style: const TextStyle(color: AppColors.white, fontSize: 25),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 40,
          ),
          bodyText(
              title:
                  "Akwaamaka TV provides a personalized subscription service that allows our members to access movies and TV shows (“ mostly Akwaamaka content”) streamed over the Internet to certain Internet-connected TVs, computers and other devices (Akwaamaka ready devices)."),
          headerText(title: 'Definition of terms'),
          bodyText(
              title:
                  "These Terms of Use govern your use of our service. As used in these Terms of Use, (Akwaamaka TV service), (our service) or (the service) means the personalized service provided by Akwaamaka TV for discovering and watching Akwaamaka TV content, including all features and functionalities, recommendations and reviews, the website, and user interfaces, as well as all content and software associated with our service."),
          headerText(title: 'Membership'),
          bodyText(
              title:
                  "1.1. Your Akwaamaka TV membership will continue until terminated. To use the AKWAMAKA service you must have a good Internet access and AKWAMAKA TV ready device, and provide us with one or more Payment Methods. “Payment Method” means a current, valid, accepted method of payment, as may be updated from time to time, and which may include payment through your account with a third party. Unless you cancel your membership before your billing date, you authorize us to charge the membership fee for the next billing cycle to your Payment Method (see Cancellation below)"),
          bodyText(
              title:
                  "1.2. We may offer a number of membership plans, including memberships offered by third parties in conjunction with the provision of their own products and services. We are not responsible for the products and services provided by such third parties. Some membership plans may have differing conditions and limitations, which will be disclosed at your sign-up or in other communications made available to you. You can find specific details regarding your Akwaamaka membership by visiting our website and clicking on the (Account) link available at the top of the pages under your profile name.•	Promotional Offers. We may from time to time offer special promotional offers, plans or memberships (“Offers”). Offer eligibility is determined by Akwaamaka at its sole discretion and we reserve the right to revoke an Offer and put your account on hold in the event that we determine you are not eligible. Members of households with an existing or recent Akwaamaka membership may not be eligible for certain introductory Offers. We may use information such as device ID, method of payment or an account email address used with an existing or recent Akwaamaka membership to determine Offer eligibility. The eligibility requirements and other limitations and conditions will be disclosed when you sign-up for the Offer or in other communications made available to you."),
          headerText(title: 'Billing and Cancellation'),
          bodyText(
              title:
                  "3.1. Billing Cycle. The membership fee for the Akwaamaka tv service and any other charges you may incur in connection with your use of the service, such as taxes and possible transaction fees, will be charged to your Payment Method on the specific payment date indicated on the (Account) page. The length of your billing cycle will depend on the type of subscription that you choose when you signed-up for the service. In some cases your payment date may change, for example if your Payment Method has not successfully settled, when you change your subscription plan or if your paid membership began on a day not contained in a given month. Visit our website and click on the (Billing details) link on the (Account) page to see your next payment date. We may authorize your Payment Method in anticipation of membership or service-related charges through various methods, including authorizing it for up to approximately one month of service as soon as you register. If you signed up for Akwaamaka using your account with a third party as a Payment Method, you can find the billing information about your Akwaamaka membership by visiting your account with the applicable third party."),
          bodyText(
              title:
                  "3.2. Payment Methods. To use the Akwaamaka services, you must provide one or more Payment Methods. You authorize us to charge any Payment Method associated to your account in case your primary Payment Method is declined or no longer available to us for payment of your subscription fee. You remain responsible for any uncollected amounts. If a payment is not successfully settled, due to expiration, insufficient funds, or otherwise, and you do not cancel your account, we may suspend your access to the service until we have successfully charged a valid Payment Method. For some Payment Methods, the issuer may charge you certain fees, such as foreign transaction fees or other fees relating to the processing of your Payment Method. Local tax charges may vary depending on the Payment Method used. Check with your Payment Method service provider for details."),
          bodyText(
              title:
                  "3.3. Updating your Payment Methods. You can update your Payment Methods by going to the (Account) page. We may also update your Payment Methods using information provided by the payment service providers. Following any update, you authorize us to continue to charge the applicable Payment Method(s)."),
          bodyText(
              title:
                  "3.4. Cancellation. You can cancel your Akwaamaka tv membership at any time, and you will continue to have access to the Akwaamaka tv service through the end of your billing period. To the extent permitted by the applicable law, payments are non-refundable and we do not provide refunds or credits for any partial membership periods or unwatched Akwaamaka tv content. To cancel, go to the (Account) page and follow the instructions for cancellation. If you cancel your membership, your account will automatically close at the end of your current billing period. To see when your account will close, click (Billing details) on the (Account) page. If you signed up for Akwaamaka tv using your account with a third party as a Payment Method and wish to cancel your Akwaamaka tv membership, you may need to do so through such third party, for example by visiting your account with the applicable third party and turning off auto-renew, or unsubscribing from the Akwaamaka tv service through that third party."),
          bodyText(
              title:
                  "3.5. Changes to the Price and Subscription Plans. We may change our subscription plans and the price of our service from time to time; however, any price changes or changes to your subscription plans will apply no earlier than 30 days following notice to you when necessary."),
          headerText(title: 'Akwaamaka TV Service'),
          bodyText(
              title:
                  "4.1. You must be at least 18 years of age, or the age of majority in your province, territory or country, to become a member of the Akwaamaka service. Minors may only use the service under the supervision of an adult."),
          bodyText(
              title:
                  "4.2. The Akwaamaka TV service and any content viewed through the service are for your personal and non-commercial use only and may not be shared with individuals beyond your household. During your Akwaamaka TV membership we grant you a limited, non-exclusive, non-transferable right to access the Akaamaka service and view Akwaamaka TV content. Except for the foregoing, no right, title or interest shall be transferred to you. You agree not to use the service for public performances."),
          bodyText(
              title:
                  "4.3. You may view the Akwaamaka TV content primarily within the country in which you have established your account and only in geographic locations where we offer our service and have licensed such content. The content that may be available to watch will vary by geographic location and will change from time to time. The number of devices on which you may simultaneously watch depends on your chosen subscription plan and is specified on the (Account) page"),
          bodyText(
              title:
                  "4.4. The Akwaamaka TV service, including the content library, is regularly updated. In addition, we continually test various aspects of our service, including our website, user interfaces, promotional features and availability of Akwaamaka TV content. You can turn off tests participation at any time by visiting the (Account) page and changing the (Test participation) settings."),
          bodyText(
              title:
                  "4.5. Some Akwaamaka TV content is available for temporary download and offline viewing on certain supported devices (“Offline Titles”). Limitations apply, including restrictions on the number of Offline Titles per account, the maximum number of devices that can contain Offline Titles, the time period within which you will need to begin viewing Offline Titles and how long the Offline Titles will remain accessible. Some Offline Titles may not be playable in certain countries and if you go online in a country where you would not be able to stream that Offline Title, the Offline Title will not be playable while you are in that country."),
          bodyText(
              title:
                  "4.6. You agree to use the Akwaamaka TV service, including all features and functionalities associated therewith, in accordance with all applicable laws, rules and regulations, or other restrictions on use of the service or content therein. You agree not to archive, reproduce, distribute, modify, display, perform, publish, license, create derivative works from, offer for sale, or use (except as explicitly authorized in these Terms of Use) content and information contained on or obtained from or through the Akwaamaka TV service. You also agree not to: circumvent, remove, alter, deactivate, degrade or thwart any of the content protections in the Akwaamaka TV service; use any robot, spider, scraper or other automated means to access the Akwaamaka TV service; decompile, reverse engineer or disassemble any software or other products or processes accessible through the Akwaamaka TV service; insert any code or product or manipulate the content of the Akwaamaka TV service in any way; or use any data mining, data gathering or extraction method. In addition, you agree not to upload, post, e-mail or otherwise send or transmit any material designed to interrupt, destroy or limit the functionality of any computer software or hardware or telecommunications equipment associated with the Akwaamaka TV service, including any software viruses or any other computer code, files or programs. We may terminate or restrict your use of our service if you violate these Terms of Use or are engaged in illegal or fraudulent use of the service."),
          bodyText(
              title:
                  "4.7. The quality of the display of the Akwaamaka TV content may vary from device to device, and may be affected by a variety of factors, such as your location, the bandwidth available through and/or speed of your Internet connection. HD, Ultra HD and HDR availability is subject to your Internet service and device capabilities. Not all content is available in all formats, such as HD, Ultra HD or HDR and not all subscription plans allow you to receive content in all formats. Default playback settings on cellular networks exclude HD, Ultra HD and HDR content. The minimum connection speed for SD quality is 1.0 Mbps; however, we recommend a faster connection for improved video quality. A download speed of at least 3.0 Mbps per stream is recommended to receive HD content (defined as a resolution of 720p or higher). A download speed of at least 15.0 Mbps per stream is recommended to receive Ultra HD (defined as a resolution of 4K or higher). You are responsible for all Internet access charges. Please check with your Internet provider for information on possible Internet data usage charges. The time it takes to begin watching Akwaamaka TV content will vary based on a number of factors, including your location, available bandwidth at the time, availability of network, the content you have selected and the configuration of your Akwaamaka TV ready device."),
          bodyText(
              title:
                  "4.8. Akwaamaka TV software is developed by, or for, Akwaamaka TV and may solely be used for authorized streaming and viewing of Akwaamaka TV content  through Akwaamaka TV ready devices. This software may vary by device and medium, and functionalities and features may also differ between devices. You acknowledge that the use of the service may require third party software that is subject to third party licenses. You agree that you may automatically receive updated versions of the Akwaamaka TV software and related third-party software."),
          headerText(title: 'Passwords and Account Access.'),
          bodyText(
              title:
                  "The member who created the Akwaamaka TV account and whose Payment Method is charged (the Account Owner) is responsible for any activity that occurs through the Akwaamaka TV account. To maintain control over the account and to prevent anyone from accessing the account (which would include information on viewing history for the account), the Account Owner should maintain control over the Akwaamaka TV ready devices that are used to access the service and not reveal the password or details of the Payment Method associated with the account to anyone. You are responsible for updating and maintaining the accuracy of the information you provide to us relating to your account. We can terminate your account or place your account on hold in order to protect you, Akwaamaka TV or our partners from identity theft or other fraudulent activity."),
          headerText(title: 'Warranties and Limitations on Liability.'),
          bodyText(
              title:
                  "The Akwaamaka TV service is provided (as is) and without warranty or condition. In particular, our service may not be uninterrupted or error-free. You waive all special, indirect and consequential damages against us. These terms will not limit any non-waivable warranties or consumer protection rights that you may be entitled to under the mandatory laws of your country of residence"),
          headerText(title: 'Class Action Waiver.'),
          bodyText(
              title:
                  "WHERE PERMITTED UNDER THE APPLICABLE LAW, YOU AND AKWAAMAKA AGREE THAT EACH MAY BRING CLAIMS AGAINST THE OTHER ONLY IN YOUR OR ITS INDIVIDUAL CAPACITY AND NOT AS A PLAINTIFF OR CLASS MEMBER IN ANY PURPORTED CLASS OR REPRESENTATIVE PROCEEDING. Further, where permitted under the applicable law, unless both you and  Akwaamaka TV agree otherwise, the court may not consolidate more than one person's claims with your claims, and may not otherwise preside over any form of a representative or class proceeding •	Alternative dispute resolution: In the event of any dispute between the parties, a report of such complaint shall be sent to Akwaamaka TV and if not settled amicably between the parties, such dispute shall first be sent to the Lagos State Multi-door court."),
          headerText(title: 'Miscellaneous'),
          bodyText(
              title:
                  "8.1. Governing Law. These Terms of Use shall be governed by and construed in accordance with the laws of the Federal Republic of Nigeria."),
          bodyText(
              title:
                  "8.2. Unsolicited Materials. Akwaamaka TV does not accept unsolicited materials or ideas for Akwaamaka TV content and is not responsible for the similarity of any of its content or programming in any media to materials or ideas transmitted to Akwaamaka TV."),
          bodyText(
              title:
                  "8.3. Customer Support. To find more information about our service and its features or if you need assistance with your account, please visit the Akwamaka TV Help Center on our website. In certain instances, Customer Service may best be able to assist you by using a remote access support tool through which we have full access to your computer. If you do not want us to have this access, you should not consent to support through the remote access tool, and we will assist you through other means. In the event of any conflict between these Terms of Use and information provided by Customer Support or other portions of our website, these Terms of Use will control."),
          bodyText(
              title:
                  "8.4. Survival. If any provision or provisions of these Terms of Use shall be held to be invalid, illegal, or unenforceable, the validity, legality and enforceability of the remaining provisions shall remain in full force and effect."),
          bodyText(
              title:
                  "8.5. Changes to Terms of Use and Assignment. Akwaamaka TV may, from time to time, change these Terms of Use. We will notify you at least 30 days before such changes apply to you. We may assign or transfer our agreement with you including our associated rights and obligations at any time and you agree to cooperate with us in connection with such an assignment or transfer."),
          bodyText(
              title:
                  "8.6. Electronic Communications. We will send you information relating to your account (e.g. payment authorizations, invoices, changes in password or Payment Method, confirmation messages, notices) in electronic form only, for example via emails to your email address provided during registration and upon registration, you consent to receiving update through your email from us from time to time"),
          headerText(title: 'Last Updated:'),
          bodyText(title: "September 1, 2022"),
        ],
      ),
    );
  }
}
