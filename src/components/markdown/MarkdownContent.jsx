import React from 'react';
import ReactMarkdown from 'react-markdown';

const markdownStyles = {
  heading: {
    h1: "text-4xl font-bold mt-8 mb-4",
    h2: "text-3xl font-bold mt-8 mb-4",
    h3: "text-2xl font-bold mt-6 mb-3",
    h4: "text-xl font-bold mt-6 mb-3",
    h5: "text-lg font-bold mt-4 mb-2",
    h6: "text-base font-bold mt-4 mb-2"
  },
  paragraph: "mb-4 text-gray-700",
  list: "list-disc pl-6 mb-4 space-y-2",
  listItem: "text-gray-700",
  link: "text-blue-600 hover:underline"
};

export default function MarkdownContent({ content }) {
  return (
    <ReactMarkdown
      components={{
        h1: ({node, ...props}) => <h1 className={markdownStyles.heading.h1} {...props} />,
        h2: ({node, ...props}) => <h2 className={markdownStyles.heading.h2} {...props} />,
        h3: ({node, ...props}) => <h3 className={markdownStyles.heading.h3} {...props} />,
        h4: ({node, ...props}) => <h4 className={markdownStyles.heading.h4} {...props} />,
        h5: ({node, ...props}) => <h5 className={markdownStyles.heading.h5} {...props} />,
        h6: ({node, ...props}) => <h6 className={markdownStyles.heading.h6} {...props} />,
        p: ({node, ...props}) => <p className={markdownStyles.paragraph} {...props} />,
        ul: ({node, ...props}) => <ul className={markdownStyles.list} {...props} />,
        li: ({node, ...props}) => <li className={markdownStyles.listItem} {...props} />,
        a: ({node, ...props}) => <a className={markdownStyles.link} {...props} />
      }}
    >
      {content}
    </ReactMarkdown>
  );
}

