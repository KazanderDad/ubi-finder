import React, { useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { ChevronLeft, Leaf } from "lucide-react";
import { useNavigate } from "react-router-dom";
import MarkdownContent from "@/components/markdown/MarkdownContent";


const disclaimerContent = `
# Disclaimer

## 1. General Information

The information provided by UBI Finder ("we," "us," or "our") on our website is for general informational purposes only. All information on the site is provided in good faith, however, we make no representation or warranty of any kind, express or implied, regarding the accuracy, adequacy, validity, reliability, availability, or completeness of any information on the site.

## 2. No Professional Advice

The content provided on UBI Finder is not intended to be a substitute for professional financial, legal, or other advice. You should not take action based solely on the information provided on our website without consulting with appropriate professionals.

## 3. Universal Basic Income Programs

### 3.1 Program Information

UBI Finder aims to provide accurate and up-to-date information about Universal Basic Income programs worldwide. However:

* Program details may change without notice
* Application processes may be modified by program providers
* Eligibility criteria may be updated or interpreted differently by program administrators
* We cannot guarantee the continued existence of any program listed on our platform

### 3.2 Third-Party Programs

We do not operate, manage, or control any of the UBI programs listed on our platform. We are not responsible for the actions, policies, or decisions of program operators. We encourage users to verify all information directly with the program providers before submitting any applications or providing personal information.

### 3.3 Program Verification

While we make reasonable efforts to verify program legitimacy before listing them on our platform, we cannot absolutely guarantee that every program is legitimate or will operate as described.

## 4. External Links

Our website may contain links to external websites that are not provided or maintained by or in any way affiliated with us. Please note that we do not guarantee the accuracy, relevance, timeliness, or completeness of any information on these external websites.

## 5. Limitation of Liability

In no event shall UBI Finder be liable for any special, direct, indirect, consequential, or incidental damages or any damages whatsoever, whether in an action of contract, negligence, or other tort, arising out of or in connection with the use of the Service or the contents of the Service.

## 6. "Use at Your Own Risk"

The information on UBI Finder is provided "as is," with no guarantees of completeness, accuracy, usefulness, or timeliness. Your use of this website and any information or materials on it is entirely at your own risk.

## 7. Contact Us

If you have any questions about this Disclaimer, please contact us:

Email: legal@ubifinder.org
`;

export default function Disclaimer() {
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
            <h1 className="text-3xl font-bold text-green-900">Disclaimer</h1>
            <p className="text-green-700 mt-2">Last Updated: {lastUpdated}</p>
          </div>

          <Card className="mb-8">
            <CardContent className="p-6">
              <MarkdownContent content={disclaimerContent} />
            </CardContent>
          </Card>
        </div>
      </div>
      
    </>
  );
}

