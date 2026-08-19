





import { supabase } from "@/lib/supabaseClient";
import React, { useState, useEffect } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { ScrollArea } from "@/components/ui/scroll-area";
import { Leaf, X, Calendar, Tag, User as UserIcon } from "lucide-react";
import { format, parseISO } from "date-fns";
import ReactMarkdown from "react-markdown";
import { useNavigate } from "react-router-dom";
import { createPageUrl } from "@/utils";


export default function Blog() {
  const navigate = useNavigate();
  const [posts, setPosts] = useState([]);
  const [programs, setPrograms] = useState([]);
  const [referencedPrograms, setReferencedPrograms] = useState([]);
  const [selectedPrograms, setSelectedPrograms] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      const [postsRes, programsRes] = await Promise.all([
        supabase.from('blog_posts').select('*').order('posted_date', { ascending: false }),
        supabase.from('programs').select('*')
      ]);
      
      const allPosts = postsRes.data || [];
      const allPrograms = programsRes.data || [];
      
      setPosts(allPosts);
      setPrograms(allPrograms);
      
      // Extract all unique program IDs referenced in blog posts
      const referencedProgramIds = new Set();
      allPosts.forEach(post => {
        if (post.related_programs && Array.isArray(post.related_programs)) {
          post.related_programs.forEach(id => referencedProgramIds.add(parseInt(id)));
        }
      });
      
      // Filter programs to only include those referenced in posts
      const filteredPrograms = allPrograms.filter(program => 
        referencedProgramIds.has(program.program_id)
      );
      
      setReferencedPrograms(filteredPrograms);
      setLoading(false);
    } catch (error) {
      console.error("Error loading blog data:", error);
      setLoading(false);
    }
  };

  const handleProgramSelect = (programId) => {
    const numericId = parseInt(programId);
    if (!selectedPrograms.includes(numericId)) {
      setSelectedPrograms([...selectedPrograms, numericId]);
    }
  };

  const handleRemoveProgram = (programId) => {
    const numericId = parseInt(programId);
    setSelectedPrograms(selectedPrograms.filter(id => id !== numericId));
  };

  const getFilteredPosts = () => {
    if (selectedPrograms.length === 0) return posts;
    
    return posts.filter(post => {
      if (!post.related_programs) return false;
      return selectedPrograms.some(programId => 
        post.related_programs.includes(programId.toString())
      );
    });
  };

  const getProgramName = (programId) => {
    const program = programs.find(p => p.program_id === parseInt(programId));
    return program ? program.name : '';
  };

  // Format date safely
  const formatDate = (dateString) => {
    try {
      // Make sure we have a valid date string
      if (!dateString) return "Unknown date";
      
      const date = parseISO(dateString);
      return format(date, 'MMM d, yyyy');
    } catch (error) {
      console.error("Error formatting date:", error);
      return "Unknown date";
    }
  };

  // Inside the Blog component, add this helper function:
  const getProgramsForPost = (post) => {
    if (!post.related_programs) return [];
    return post.related_programs
      .map(programId => programs.find(p => p.program_id === parseInt(programId)))
      .filter(Boolean); // Remove any undefined values
  };

  // Updated to use the exact format matching the page filename
  const handlePostClick = (postId) => {
    navigate(createPageUrl("BlogPost"), { 
      state: { postId, from: 'blog' }
    });
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-green-700"></div>
      </div>
    );
  }

  return (
    <>
      <div className="min-h-screen bg-gradient-to-b from-green-50 via-white to-yellow-50 px-4 py-12">
        <div className="max-w-4xl mx-auto">
          <div className="text-center mb-8">
            <div className="inline-block p-2 bg-green-100 rounded-full mb-4">
              <Leaf className="w-8 h-8 text-green-700" />
            </div>
            <h1 className="text-3xl font-bold text-green-900">UBI News & Updates</h1>
            <p className="text-lg text-green-700 mt-2">
              Latest news and insights about Universal Basic Income programs
            </p>
          </div>

          {/* Program Filter */}
          <Card className="mb-8">
            <CardHeader>
              <CardTitle className="text-xl font-semibold">Filter by Program</CardTitle>
            </CardHeader>
            <CardContent>
              <div className="space-y-4">
                {referencedPrograms.length > 0 ? (
                  <>
                    <Select onValueChange={handleProgramSelect}>
                      <SelectTrigger>
                        <SelectValue placeholder="Select programs to filter" />
                      </SelectTrigger>
                      <SelectContent>
                        {referencedPrograms.map(program => (
                          <SelectItem 
                            key={program.program_id} 
                            value={program.program_id.toString()}
                            disabled={selectedPrograms.includes(program.program_id)}
                          >
                            {program.name}
                          </SelectItem>
                        ))}
                      </SelectContent>
                    </Select>

                    {selectedPrograms.length > 0 && (
                      <ScrollArea className="w-full">
                        <div className="flex flex-wrap gap-2 py-2">
                          {selectedPrograms.map(programId => (
                            <Badge 
                              key={programId}
                              variant="secondary"
                              className="py-1 px-3 flex items-center gap-2"
                            >
                              {getProgramName(programId)}
                              <button
                                onClick={() => handleRemoveProgram(programId)}
                                className="hover:bg-gray-200 rounded-full p-1"
                              >
                                <X className="h-3 w-3" />
                              </button>
                            </Badge>
                          ))}
                        </div>
                      </ScrollArea>
                    )}
                  </>
                ) : (
                  <p className="text-gray-500 text-center">No programs are referenced in blog posts yet.</p>
                )}
              </div>
            </CardContent>
          </Card>

          {/* Blog Posts */}
          <div className="space-y-8">
            {getFilteredPosts().map(post => (
              <Card 
                key={post.id} 
                className="overflow-hidden hover:shadow-lg transition-shadow cursor-pointer"
                onClick={() => handlePostClick(post.id)}
              >
                {post.image_url && (
                  <img 
                    src={post.image_url} 
                    alt={post.title}
                    className="w-full h-48 object-cover"
                  />
                )}
                <CardContent className="p-6">
                  <h2 className="text-2xl font-bold text-green-900 mb-2">
                    {post.title}
                  </h2>
                  
                  <div className="flex items-center gap-4 text-sm text-gray-600 mb-4">
                    <div className="flex items-center gap-1">
                      <Calendar className="w-4 h-4" />
                      {formatDate(post.posted_date)}
                    </div>
                    <div className="flex items-center gap-1">
                      <UserIcon className="w-4 h-4" />
                      {post.author}
                    </div>
                  </div>

                  {post.related_programs && post.related_programs.length > 0 && (
                    <div className="flex flex-wrap gap-2 mb-4">
                      {getProgramsForPost(post).map(program => (
                        <Badge key={program.program_id} variant="outline">
                          {program.name}
                        </Badge>
                      ))}
                    </div>
                  )}

                  <p className="text-gray-600 mb-4">{post.summary}</p>

                  <div className="prose max-w-none">
                    <ReactMarkdown>{post.content}</ReactMarkdown>
                  </div>

                  {post.tags && post.tags.length > 0 && (
                    <div className="flex items-center gap-2 mt-6 pt-4 border-t">
                      <Tag className="w-4 h-4 text-gray-500" />
                      <div className="flex flex-wrap gap-2">
                        {post.tags.map(tag => (
                          <Badge 
                            key={tag} 
                            variant="secondary"
                            className="bg-gray-100"
                          >
                            {tag}
                          </Badge>
                        ))}
                      </div>
                    </div>
                  )}
                </CardContent>
              </Card>
            ))}

            {getFilteredPosts().length === 0 && (
              <div className="text-center py-12">
                <p className="text-gray-500">No blog posts found for the selected programs.</p>
              </div>
            )}
          </div>
        </div>
      </div>
      
    </>
  );
}

