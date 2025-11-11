(cons* (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
        (introduction
          (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
            "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
        (channel
          (name 'guix-zephyr)
          (url "https://github.com/paperclip4465/guix-zephyr")
          ;; Enable signature verification:
          (introduction
           (make-channel-introduction
            "a0146bb3d13920074d40ed6d6d53321b17e267fb"
            (openpgp-fingerprint
             "089F 0E56 0087 9656 C463  691A 3811 C00D C428 5E27"))))
       %default-channels)
