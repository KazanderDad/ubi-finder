import React, { useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { ChevronLeft, Leaf } from "lucide-react";
import { useNavigate } from "react-router-dom";
import MarkdownContent from "@/components/markdown/MarkdownContent";


const privacyContent = `
# Privacy Policy

## 1. Introduction

Your privacy is important to us. This Privacy Policy explains how UBI Finder collects, uses, discloses, and safeguards your information when you use our service.

## 2. Information We Collect

### 2.1 Personal Information

We collect information that you provide directly to us, including:

* Name and contact information
* Demographic information
* Financial information
* Location data
* Profile information

### 2.2 Usage Information

We automatically collect certain information about your device, including:

* IP address
* Browser type
* Device identifiers
* Operating system
* Usage patterns

## 3. How We Use Your Information

We use the information we collect to:

* Match you with appropriate UBI programs
* Process your applications
* Communicate with you about opportunities
* Improve our services
* Ensure platform security
* Comply with legal obligations

## 4. Information Sharing and Disclosure

We may share your information with:

* UBI program providers (with your consent)
* Service providers and partners
* Legal authorities when required

## 5. Data Security

We implement appropriate technical and organizational measures to protect your personal information, including:

* Encryption of data in transit and at rest
* Regular security assessments
* Access controls and authentication
* Employee training on data protection

## 6. Your Rights and Choices

You have the right to:

* Access your personal information
* Correct inaccurate data
* Request deletion of your data
* Opt-out of certain data processing
* Withdraw consent at any time

## 7. Children's Privacy

Our Service is not directed to children under 13. We do not knowingly collect personal information from children under 13. If you become aware that a child has provided us with personal information, please contact us.

## 8. International Data Transfers

Your information may be transferred to and processed in countries other than your own. We ensure appropriate safeguards are in place for such transfers.

## 9. Changes to This Policy

We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date.

## 10. Contact Us

If you have any questions about this Privacy Policy, please contact us at:

Email: privacy@firebelly.xyz
`;

export default function Privacy() {
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
            <h1 className="text-3xl font-bold text-green-900">Privacy Policy</h1>
            <p className="text-green-700 mt-2">Last Updated: {lastUpdated}</p>
          </div>

          <Card className="mb-8">
            <CardContent className="p-6">
              <MarkdownContent content={privacyContent} />
            </CardContent>
          </Card>
        </div>
      </div>
      
    </>
  );
}

