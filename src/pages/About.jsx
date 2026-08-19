
import React, { useEffect } from "react";
import { Button } from "@/components/ui/button";
import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion";
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";
import { Leaf, Mail, MessageSquare, ExternalLink, FileText } from "lucide-react";
import { Link } from "react-router-dom";
import { createPageUrl } from "@/utils";


import PageHeader from "@/components/ui/page-header";

export default function About() {
  useEffect(() => {
    window.scrollTo(0, 0);
  }, []);

  return (
    <>
      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-12">
        <div className="max-w-4xl mx-auto">
          <PageHeader
            icon={Leaf}
            title="About UBI Finder"
            subtitle="Connecting people with verified Universal Basic Income and cash support opportunities worldwide."
          />

          {/* About UBI Section */}
          <Card className="mb-10 shadow-md">
            <CardHeader>
              <CardTitle>About Universal Basic Income</CardTitle>
              <CardDescription>Understanding the concept and its importance</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <p>
                Universal Basic Income (UBI) is a regular financial payment provided to individuals without a means test or work requirement. The core principles of UBI include:
              </p>
              <ul className="list-disc pl-6 space-y-2">
                <li>
                  <span className="font-medium">Universality:</span> It is paid to everyone within a defined community or region.
                </li>
                <li>
                  <span className="font-medium">Unconditionality:</span> Recipients don't need to meet specific criteria or perform tasks to receive it.
                </li>
                <li>
                  <span className="font-medium">Regularity:</span> Payments are made at scheduled intervals, not as one-time grants.
                </li>
                <li>
                  <span className="font-medium">Individual basis:</span> Payments go to individuals, not households.
                </li>
              </ul>
              <p>
                UBI programs are being tested worldwide as potential solutions to poverty, economic inequality, and technological unemployment. These programs vary in scope, amount, and implementation details, but all share the core goal of providing financial stability and freedom to individuals.
              </p>
              <div className="flex justify-end">
                <Button variant="outline" onClick={() => window.open('https://basicincome.org/about-basic-income/', '_blank')}>
                  Learn more about UBI
                  <ExternalLink className="ml-2 h-4 w-4" />
                </Button>
              </div>
            </CardContent>
          </Card>

          {/* About This Site */}
          <Card className="mb-10 shadow-md">
            <CardHeader>
              <CardTitle>About This Site</CardTitle>
              <CardDescription>Our mission and purpose</CardDescription>
            </CardHeader>
            <CardContent className="space-y-4">
              <p>
                UBI Finder was created to bridge the gap between UBI programs and potential recipients. Our platform aims to:
              </p>
              <ul className="list-disc pl-6 space-y-2">
                <li>Help individuals discover UBI opportunities available in their region</li>
                <li>Provide detailed information about program requirements and application processes</li>
                <li>Support traditional and digital currency payment options</li>
                <li>Create a community of UBI recipients and advocates</li>
                <li>Track and showcase the impact of UBI programs globally</li>
              </ul>
              <p>
                We are not affiliated with any government or specific UBI program. Our goal is to provide neutral, accurate information to help people access potential income support opportunities.
              </p>
              <div className="mt-6 p-4 bg-green-50 rounded-lg border border-green-100">
                <div className="flex items-start">
                  <FileText className="w-5 h-5 text-green-700 mr-3 mt-1" />
                  <div>
                    <h4 className="font-medium text-green-900 mb-1">Our Commitment</h4>
                    <p className="text-sm text-green-800">
                      We verify all programs listed on our platform to ensure they are legitimate opportunities. However, we recommend users conduct their own research before sharing personal or financial information with any program.
                    </p>
                  </div>
                </div>
              </div>
            </CardContent>
          </Card>

          {/* FAQs */}
          <Card className="mb-10 shadow-md">
            <CardHeader>
              <CardTitle>Frequently Asked Questions</CardTitle>
              <CardDescription>Common questions about UBI and our platform</CardDescription>
            </CardHeader>
            <CardContent>
              <Accordion type="single" collapsible className="w-full">
                <AccordionItem value="item-1">
                  <AccordionTrigger>What is the difference between UBI and welfare?</AccordionTrigger>
                  <AccordionContent>
                    Unlike traditional welfare programs, Universal Basic Income is provided without conditions or means testing. It's given to everyone in a community regardless of employment status or income level, eliminating stigma and complex bureaucracy while providing financial security.
                  </AccordionContent>
                </AccordionItem>
                <AccordionItem value="item-2">
                  <AccordionTrigger>How are UBI programs funded?</AccordionTrigger>
                  <AccordionContent>
                    UBI funding varies by program. Some are funded by governments through tax revenue or resource dividends (like Alaska's Permanent Fund). Others are supported by nonprofits, community organizations, or blockchain projects with dedicated funding mechanisms. Each program on our platform includes information about its funding source.
                  </AccordionContent>
                </AccordionItem>
                <AccordionItem value="item-3">
                  <AccordionTrigger>Does UBI Finder charge fees?</AccordionTrigger>
                  <AccordionContent>
                    No, UBI Finder is completely free for users. We do not charge fees for connecting individuals with programs or for creating profiles. Our platform is supported by grants and partnerships with organizations interested in advancing UBI research and implementation.
                  </AccordionContent>
                </AccordionItem>
                <AccordionItem value="item-4">
                  <AccordionTrigger>How do you verify the programs listed?</AccordionTrigger>
                  <AccordionContent>
                    Each program undergoes a verification process where we check the organization's legitimacy, funding sources, and track record. Programs marked as "Verified" have passed our review process, which includes confirming the organization exists, has transparent funding, and has successfully distributed payments in the past or has secured funding for upcoming distributions.
                  </AccordionContent>
                </AccordionItem>
                <AccordionItem value="item-5">
                  <AccordionTrigger>Can I participate in multiple UBI programs?</AccordionTrigger>
                  <AccordionContent>
                    This depends on the specific rules of each program. Some UBI programs allow participation in multiple initiatives, while others may require exclusive participation. Each program listing includes information about compatibility with other income support programs. We recommend checking the details of each program you're interested in.
                  </AccordionContent>
                </AccordionItem>
              </Accordion>
            </CardContent>
          </Card>

          {/* Contact Us */}
          <Card className="mb-10 shadow-md">
            <CardHeader>
              <CardTitle>Contact Us</CardTitle>
              <CardDescription>Get in touch with our team</CardDescription>
            </CardHeader>
            <CardContent className="space-y-6">
              <div className="grid md:grid-cols-2 gap-8">
                <div className="flex items-start">
                  <div className="bg-green-100 p-3 rounded-full mr-4">
                    <Mail className="h-6 w-6 text-green-700" />
                  </div>
                  <div>
                    <h3 className="font-medium text-green-900 mb-1">Email Us</h3>
                    <p className="text-sm text-green-800 mb-2">For general inquiries and support</p>
                    <a href="mailto:info@ubifinder.org" className="text-green-600 hover:text-green-800 font-medium">
                      info@ubifinder.org
                    </a>
                  </div>
                </div>
                
                <div className="flex items-start">
                  <div className="bg-green-100 p-3 rounded-full mr-4">
                    <MessageSquare className="h-6 w-6 text-green-700" />
                  </div>
                  <div>
                    <h3 className="font-medium text-green-900 mb-1">Community</h3>
                    <p className="text-sm text-green-800 mb-2">Join our discussion forums</p>
                    <Link to={createPageUrl("Community")} className="text-green-600 hover:text-green-800 font-medium">
                      Visit Community Page
                    </Link>
                  </div>
                </div>
              </div>
              
              <Separator className="my-6" />
              
              <div>
                <h3 className="font-medium text-green-900 mb-4">Submit a Program</h3>
                <p className="text-sm text-green-800 mb-4">
                  Know of a UBI program that's not listed on our platform? Help us grow our database by submitting information about it.
                </p>
                <Link to={createPageUrl("Submit-Program")}>
                  <Button className="bg-green-700 hover:bg-green-800">
                    Submit Program
                  </Button>
                </Link>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
      
    </>
  );
}

