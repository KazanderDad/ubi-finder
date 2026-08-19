import React, { useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { ChevronLeft, Leaf } from "lucide-react";
import { useNavigate } from "react-router-dom";
import MarkdownContent from "@/components/markdown/MarkdownContent";


const cookiePolicyContent = `
# Cookie Policy

## 1. What Are Cookies

Cookies are small text files that are placed on your computer or mobile device when you visit a website. Cookies are widely used to make websites work more efficiently and provide information to the owners of the site.

## 2. How We Use Cookies

UBI Finder uses cookies for several purposes, including:

### 2.1 Essential Cookies

These cookies are necessary for the website to function properly. They enable core functionality such as security, network management, and account access. You cannot opt out of these cookies.

### 2.2 Analytics Cookies

These cookies help us understand how visitors interact with our website by collecting and reporting information anonymously. This helps us improve the website experience for all users.

### 2.3 Functional Cookies

These cookies enable enhanced functionality and personalization. They may be set by us or by third-party providers whose services we have added to our pages.

### 2.4 Targeting Cookies

These cookies may be set through our site by our advertising partners. They may be used by those companies to build a profile of your interests and show you relevant advertisements on other sites.

## 3. Managing Cookies

Most web browsers allow you to manage your cookie preferences. You can:

* Delete cookies from your device
* Block cookies by activating settings on your browser
* Choose to reject all cookies
* Allow all cookies
* Manage cookies on a site-by-site basis

Please note that if you choose to block or delete cookies, you may not be able to access certain areas or features of our Service, and some functionality may be affected.

## 4. Third-Party Cookies

Our Service may use certain third-party services, each of which may set their own cookies. We do not control the placement of cookies by third parties. Third parties may use cookies, web beacons, and similar technologies to collect or receive information from our website and elsewhere on the internet and use that information to provide measurement services and targeted advertisements.

## 5. Changes to This Policy

We may update our Cookie Policy from time to time. We will notify you of any changes by posting the new Cookie Policy on this page and updating the "last updated" date.

## 6. Contact Us

If you have any questions about our use of cookies, please contact us at:

Email: privacy@ubifinder.org
`;

export default function CookiePolicy() {
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
            <h1 className="text-3xl font-bold text-green-900">Cookie Policy</h1>
            <p className="text-green-700 mt-2">Last Updated: {lastUpdated}</p>
          </div>

          <Card className="mb-8">
            <CardContent className="p-6">
              <MarkdownContent content={cookiePolicyContent} />
            </CardContent>
          </Card>
        </div>
      </div>
      
    </>
  );
}

