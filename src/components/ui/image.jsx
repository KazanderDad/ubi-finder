import * as React from "react"
import { cn } from "@/lib/utils"

const FALLBACK_IMAGE_URL = "/placeholder.svg" // Replace with an actual local generic fallback if available

/** @type {React.ForwardRefExoticComponent<any>} */
const Image = React.forwardRef(({ src, className, style, alt = "", onError, ...props }, ref) => {
  const [hasError, setHasError] = React.useState(false)

  React.useEffect(() => {
    setHasError(false)
  }, [src])

  const handleError = (e) => {
    setHasError(true)
    onError?.(e)
  }

  const imageSrc = !src || hasError ? FALLBACK_IMAGE_URL : src

  return (
    <img 
      ref={ref} 
      src={imageSrc} 
      className={cn("w-full h-full object-cover", className)}
      style={style}
      alt={alt}
      onError={handleError}
      {...props} 
    />
  )
})
Image.displayName = "Image"

export { Image }
