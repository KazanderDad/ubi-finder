import React, { useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { ChevronLeft, Leaf } from "lucide-react";
import { useNavigate } from "react-router-dom";
import MarkdownContent from "@/components/markdown/MarkdownContent";


const accessibilityContent = `
# Accessibility Statement

## Our Commitment

UBI Finder is committed to ensuring digital accessibility for people with disabilities. We are continually improving the user experience for everyone and applying the relevant accessibility standards.

## Conformance Status

We aim to conform to the Web Content Accessibility Guidelines (WCAG) 2.1 Level AA standards. These guidelines explain how to make web content more accessible for people with disabilities and more user-friendly for everyone.

## Accessibility Features

Our website includes the following accessibility features:

* Clear heading structure and navigation
* Alt text for all informative images
* Sufficient color contrast ratios
* Keyboard navigation support
* Text resizing without loss of functionality
* ARIA landmarks and labels
* Skip navigation links
* Form labels and error identification

## Assistive Technology Support

Our website is designed to be compatible with the following assistive technologies:

* Screen readers
* Screen magnifiers
* Speech recognition software
* Keyboard-only navigation

## Known Issues

While we strive for WCAG 2.1 Level AA compliance, there may be some areas that need improvement. We are actively working to identify and resolve any accessibility issues. Known issues are documented and prioritized for resolution.

## Feedback

We welcome your feedback on the accessibility of UBI Finder. Please let us know if you encounter accessibility barriers:

* Email: accessibility@firebelly.xyz
* Phone: [Your Phone Number]

## Compatibility

UBI Finder is designed to be compatible with:

* Latest versions of major browsers (Chrome, Firefox, Safari, Edge)
* Mobile devices and tablets
* Common screen readers (NVDA, JAWS, VoiceOver)

## Additional Resources

For more information about web accessibility, we recommend:

* Web Content Accessibility Guidelines (WCAG)
* WebAIM's accessibility resources
* A11Y Project

## Contact Us

If you have specific questions or concerns about the accessibility of UBI Finder, please contact us:

Email: accessibility@firebelly.xyz
`;

export default function Accessibility() {
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
            <h1 className="text-3xl font-bold text-green-900">Accessibility Statement</h1>
            <p className="text-green-700 mt-2">Last Updated: {lastUpdated}</p>
          </div>

          <Card className="mb-8">
            <CardContent className="p-6">
              <MarkdownContent content={accessibilityContent} />
            </CardContent>
          </Card>
        </div>
      </div>
      
    </>
  );
}

