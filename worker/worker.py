from face_recognition import face_locations, load_image_file
from PIL import Image, ImageFilter
from blur import FaceBlur
from pika import BlockingConnection, ConnectionParameters

destinyFolder = "/blurred-images"

def destinyPath(sourcePath) -> str:
    if not isinstance(sourcePath, str):
        sourcePath = sourcePath.decode("utf-8")
    barIdx = sourcePath.rfind("/")
    if barIdx > 0:
        sourcePath = sourcePath[barIdx+1:]

    return f"{destinyFolder}/{sourcePath}"

def main():
    connection = BlockingConnection(ConnectionParameters("rabbitmq"))
    channel = connection.channel()
    channel.queue_declare(queue="blur-service")

    def callback(ch, method, properties, body):
        blur = FaceBlur(body, destinyPath(body))
        blur.locateFaces()
        blur.blurFaces()
        blur.save()
    
    channel.basic_consume(queue="blur-service", on_message_callback=callback, auto_ack=True)

    channel.start_consuming()

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print('Interrupted')
        exit(0)