.class final Lchat/ola/vn/service/OlaVoiceChatService$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/service/OlaVoiceChatService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    invoke-static {}, Lchat/ola/vn/service/OlaVoiceChatService;->a()Lchat/ola/vn/message/aa;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/service/OlaVoiceChatService;->a()Lchat/ola/vn/message/aa;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v2}, Landroid/media/MediaPlayer;->getCurrentPosition()I

    move-result v2

    sget-object v3, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v3}, Landroid/media/MediaPlayer;->getDuration()I

    move-result v3

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/message/aa;->c(Ljava/lang/String;II)V

    invoke-static {}, Lchat/ola/vn/service/OlaVoiceChatService;->c()Landroid/os/Handler;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/service/OlaVoiceChatService;->b()Ljava/lang/Runnable;

    move-result-object v1

    const-wide/16 v2, 0x64

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
