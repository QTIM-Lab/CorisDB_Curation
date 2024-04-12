import os, sys
import cv2
import pandas as pd

# code = ['CFP', 'Slit Lamp', 'OCT', 'AF', 'IR', 'US', 'UWF', 'Other']
code = ['OCT', 'AF', 'IR', 'Other']

class ImageLabeler:
    def __init__(self, root, csv_path, image_col_name, save_to):
        self.image_index = 0
        self.root = root
        self.save_to = os.path.join(root, save_to)
        # resume existing annotation task
        if os.path.exists(self.save_to):
            print('Resuming annotation task...')
            self.image_list = pd.read_csv(self.save_to)
        else:
            self.image_list = pd.read_csv(os.path.join(root, csv_path))
            self.image_list['modality'] = ['None']*len(self.image_list)
        
        self.image_col_name = image_col_name
        self.size = len(self.image_list)

    def load_current_image(self):
        ''' Loads current image '''
        row = self.image_list.iloc[self.image_index]
        image = cv2.imread(row[self.image_col_name])
        image = cv2.resize(image, (256, 256))
        window_name = "Image Labeler"
        cv2.namedWindow(window_name)
        cv2.imshow(window_name, image)

    def save_code(self, code):
        self.image_list.at[self.image_index, 'modality'] = code

    def save_csv(self):
        self.image_list.to_csv(self.save_to, index=False)

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description='GUI for screening images')
    parser.add_argument('--root', help='Root directory where results saved')
    parser.add_argument('--csv-path', help='Path to csv file', type=str)
    parser.add_argument('--image-col-name', help='Name of column in csv storing images', type=str)
    parser.add_argument('--save-as', help='Save csv to location', type=str)
    args = parser.parse_args()

    labeler = ImageLabeler(args.root, args.csv_path, args.image_col_name, args.save_as)

    print('Beginning the image annotation session!')
    print('Rules: Press the correct key based on what image you see')
    print(' OCT = 1\n AF = 2\n IR = 3\n Other = 4')
    print('Hit B if you want to go to the previous image.')

    key = None

    while labeler.image_index < labeler.size:
        
        # resume from last annotated image
        if (labeler.image_list.at[labeler.image_index, 'modality'] in code) and (key != 'b'):
            print(f'Image {labeler.image_index} already annotated')
            labeler.image_index += 1

        else:
            # load image
            labeler.load_current_image()

            print(f'Loading image {labeler.image_index}')
            # wait for keypress event
            key = cv2.waitKey(0)

            if ord('1') <= key <= ord('4'): # Space bar press
                labeler.save_code(code[int(chr(key))-1])
                labeler.image_index += 1
                print(labeler.image_index, labeler.size)
                cv2.destroyAllWindows()

            elif key == ord('b'): # previous image
                labeler.image_index -= 1
                key = 'b'
                cv2.destroyAllWindows()

            elif key == ord('q'):
                cv2.destroyAllWindows()
                sys.exit(0)

            else:
                cv2.destroyAllWindows()
                raise KeyError('Invalid Key pressed. Can only press 1,2,3,4,B,Q')

            # save results
            if labeler.image_index % 10 == 0 or labeler.image_index == labeler.size - 1:
                print('Wait! Saving results...')
                labeler.save_csv()

        
