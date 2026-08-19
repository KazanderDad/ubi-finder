import { supabase } from '@/lib/supabaseClient';

export const UploadFile = async ({ file }) => {
  try {
    const fileExt = file.name.split('.').pop();
    const fileName = `${Math.random()}.${fileExt}`;
    const filePath = `public/${fileName}`;

    const { error: uploadError } = await supabase.storage
      .from('uploads')
      .upload(filePath, file);

    if (uploadError) {
      throw uploadError;
    }

    const { data } = supabase.storage
      .from('uploads')
      .getPublicUrl(filePath);

    return { file_url: data.publicUrl };
  } catch (error) {
    console.error('Error uploading file:', error);
    // Return a fallback or throw
    return { file_url: 'https://via.placeholder.com/150' };
  }
};
