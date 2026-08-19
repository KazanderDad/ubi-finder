import React, { useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { ChevronLeft, Leaf } from "lucide-react";
import { useNavigate } from "react-router-dom";
import MarkdownContent from "@/components/markdown/MarkdownContent";


const termsContent = `
# Terms of Service

## 1. Acceptance of Terms

By accessing and using UBI Finder ("the Service"), you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use the Service.

## 2. Description of Service

UBI finder is a platform that connects users with Universal Basic Income programs and opportunities. We provide information about various UBI initiatives, eligibility requirements, and application processes.

## 3. User Accounts

To access certain features of the Service, you must register for an account. You agree to:

* Provide accurate and complete information
* Maintain the security of your account credentials
* Promptly update any changes to your information
* Accept responsibility for all activities under your account

## 4. User Responsibilities

When using our Service, you agree not to:

* Submit false or misleading information
* Violate any applicable laws or regulations
* Interfere with the proper functioning of the Service
* Attempt to gain unauthorized access to any part of the Service
* Harass, abuse, or harm other users

## 5. Program Information

While we strive to provide accurate and up-to-date information about UBI programs, we cannot guarantee:

* The accuracy of all program details
* Your eligibility for any specific program
* The success of your application
* The continued availability of any program

## 6. Privacy and Data Protection

Your privacy is important to us. Our collection and use of your personal information is governed by our Privacy Policy, which is incorporated into these Terms by reference.

## 7. Intellectual Property

All content on the Service, including but not limited to text, graphics, logos, and software, is the property of UBI Finder or its licensors and is protected by copyright and other intellectual property laws.

## 8. Limitation of Liability

UBI Finder is provided "as is" without any warranties. We are not liable for:

* Any indirect, incidental, or consequential damages
* The accuracy of program information
* The outcome of program applications
* Any actions taken by third-party programs

## 9. Modifications to Service

We reserve the right to modify or discontinue the Service at any time, with or without notice. We may also update these Terms from time to time, and your continued use of the Service constitutes acceptance of any changes.

## 10. Termination

We reserve the right to terminate or suspend your account and access to the Service at our discretion, without notice, for conduct that we believe violates these Terms or is harmful to other users of the Service, us, or third parties, or for any other reason.

## 11. Governing Law

These Terms shall be governed by the laws of the jurisdiction in which UBI Finder operates, without regard to its conflict of law provisions.

## 12. Contact

If you have any questions about these Terms, please contact us at legal@ubifinder.org.
`;

export default function Terms() {
  const navigate = useNavigate();
  const lastUpdated = "April 28, 2024";

  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);

  return (
    <>
      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-12">
        <div className="max-w-4xl mx-auto">
          <Button
            variant="ghost"
            className="mb-8"
            onClick={() => navigate(-1)}
          >
            <ChevronLeft className="w-4 h-4 mr-2" />
            Back
          </Button>

          <div className="text-center mb-8">
            <div className="inline-block p-2 bg-green-100 rounded-full mb-4">
              <Leaf className="w-8 h-8 text-green-700" />
            </div>
            <h1 className="text-3xl font-bold text-green-900">Terms of Service</h1>
            <p className="text-green-700 mt-2">Last Updated: {lastUpdated}</p>
          </div>

          <Card className="mb-8">
            <CardContent className="p-6">
              <MarkdownContent content={termsContent} />
            </CardContent>
          </Card>
        </div>
      </div>
      
    </>
  );
}

