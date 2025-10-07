import os
import cv2
import pandas as pd

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
        
        self.image_col_name = image_col_name
        self.image_list['Modality'] = ['None']*len(self.image_list)
        self.size = len(self.image_list)

    def load_current_image(self):
        ''' Loads current image '''
        row = self.image_list.iloc[self.image_index]
        image = cv2.imread('coris_db_subsets/' + row[self.image_col_name])
        window_name = "Image Labeler"
        cv2.namedWindow(window_name)
        cv2.imshow(window_name, image)

    def save_modality(self, modality):
        self.image_list.at[self.image_index, 'Modality'] = modality

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

    while labeler.image_index < labeler.size:
        
        # load image
        labeler.load_current_image()

        # resume from last annotated image
        if labeler.image_list.at[labeler.image_index, 'Modality'] in ['AF', 'IR']:
            labeler.image_index += 1
        else:
            # wait for keypress event
            key = cv2.waitKey(0)

            if key == ord(' '): # Space bar press
                labeler.save_modality('AF')
                labeler.save_csv()
                labeler.image_index += 1

            elif key == ord('n'): # next image
                labeler.save_modality('IR')
                labeler.save_csv()
                labeler.image_index += 1

            elif key == ord('b'): # previous image
                labeler.image_index -= 1

            elif key == ord('q'):
                cv2.destroyAllWindows()
                labeler.save_csv()
