.class public Lchat/ola/vn/service/OlaVoiceChatService;
.super Landroid/app/Service;

# interfaces
.implements Landroid/media/MediaPlayer$OnCompletionListener;
.implements Landroid/media/MediaPlayer$OnErrorListener;
.implements Landroid/media/MediaPlayer$OnPreparedListener;
.implements Lchat/ola/vn/f/a;


# static fields
.field protected static a:Landroid/media/MediaPlayer; = null

.field private static b:Z = false

.field private static c:Z = false

.field private static d:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/message/aa;",
            ">;"
        }
    .end annotation
.end field

.field private static e:Landroid/os/Handler;

.field private static f:Ljava/lang/Runnable;

.field private static g:Lchat/ola/vn/message/aa;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lchat/ola/vn/service/OlaVoiceChatService$1;

    invoke-direct {v0}, Lchat/ola/vn/service/OlaVoiceChatService$1;-><init>()V

    sput-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->f:Ljava/lang/Runnable;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    return-void
.end method

.method static synthetic a()Lchat/ola/vn/message/aa;
    .locals 1

    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    return-object v0
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/message/aa;)V
    .locals 1

    const/4 v0, 0x1

    invoke-static {p0, p1, v0}, Lchat/ola/vn/service/OlaVoiceChatService;->a(Landroid/content/Context;Lchat/ola/vn/message/aa;Z)V

    return-void
.end method

.method private static a(Landroid/content/Context;Lchat/ola/vn/message/aa;Z)V
    .locals 2

    if-eqz p1, :cond_5

    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->d:Ljava/util/List;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/LinkedList;

    invoke-direct {v0}, Ljava/util/LinkedList;-><init>()V

    sput-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->d:Ljava/util/List;

    :cond_0
    sget-boolean v0, Lchat/ola/vn/service/OlaVoiceChatService;->c:Z

    if-eqz v0, :cond_2

    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/service/OlaVoiceChatService;->c:Z

    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    invoke-virtual {v0}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->isPlaying()Z

    move-result v0

    if-nez v0, :cond_1

    sget-object p0, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    sget-object p1, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    invoke-virtual {p1}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object p1

    sget-object p2, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {p2}, Landroid/media/MediaPlayer;->getCurrentPosition()I

    move-result p2

    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->getDuration()I

    move-result v0

    invoke-virtual {p0, p1, p2, v0}, Lchat/ola/vn/message/aa;->b(Ljava/lang/String;II)V

    sget-object p0, Lchat/ola/vn/service/OlaVoiceChatService;->e:Landroid/os/Handler;

    sget-object p1, Lchat/ola/vn/service/OlaVoiceChatService;->f:Ljava/lang/Runnable;

    invoke-virtual {p0, p1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    sget-object p0, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {p0}, Landroid/media/MediaPlayer;->start()V

    return-void

    :cond_1
    invoke-static {}, Lchat/ola/vn/service/OlaVoiceChatService;->d()V

    :cond_2
    if-eqz p2, :cond_3

    invoke-static {}, Lchat/ola/vn/service/OlaVoiceChatService;->d()V

    sget-object p2, Lchat/ola/vn/service/OlaVoiceChatService;->d:Ljava/util/List;

    invoke-interface {p2}, Ljava/util/List;->clear()V

    :cond_3
    sget-object p2, Lchat/ola/vn/service/OlaVoiceChatService;->d:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result p2

    if-nez p2, :cond_4

    sget-object p2, Lchat/ola/vn/service/OlaVoiceChatService;->d:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_4
    sget-boolean p1, Lchat/ola/vn/service/OlaVoiceChatService;->b:Z

    if-nez p1, :cond_5

    const/4 p1, 0x1

    sput-boolean p1, Lchat/ola/vn/service/OlaVoiceChatService;->b:Z

    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    const-class p2, Lchat/ola/vn/service/OlaVoiceChatService;

    invoke-virtual {p1, p0, p2}, Landroid/content/Intent;->setClass(Landroid/content/Context;Ljava/lang/Class;)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    :cond_5
    return-void
.end method

.method public static a(Lchat/ola/vn/message/aa;)V
    .locals 3

    :try_start_0
    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    invoke-virtual {v0}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object p0

    invoke-static {v0, p0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    sget-object p0, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {p0}, Landroid/media/MediaPlayer;->isPlaying()Z

    move-result p0

    if-eqz p0, :cond_0

    sget-object p0, Lchat/ola/vn/service/OlaVoiceChatService;->e:Landroid/os/Handler;

    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->f:Ljava/lang/Runnable;

    invoke-virtual {p0, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    const/4 p0, 0x1

    sput-boolean p0, Lchat/ola/vn/service/OlaVoiceChatService;->c:Z

    sget-object p0, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {p0}, Landroid/media/MediaPlayer;->pause()V

    sget-object p0, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    invoke-virtual {v0}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v1}, Landroid/media/MediaPlayer;->getCurrentPosition()I

    move-result v1

    sget-object v2, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v2}, Landroid/media/MediaPlayer;->getDuration()I

    move-result v2

    invoke-virtual {p0, v0, v1, v2}, Lchat/ola/vn/message/aa;->a(Ljava/lang/String;II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method static synthetic b()Ljava/lang/Runnable;
    .locals 1

    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->f:Ljava/lang/Runnable;

    return-object v0
.end method

.method public static b(Landroid/content/Context;Lchat/ola/vn/message/aa;)V
    .locals 1

    const/4 v0, 0x0

    invoke-static {p0, p1, v0}, Lchat/ola/vn/service/OlaVoiceChatService;->a(Landroid/content/Context;Lchat/ola/vn/message/aa;Z)V

    return-void
.end method

.method static synthetic c()Landroid/os/Handler;
    .locals 1

    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->e:Landroid/os/Handler;

    return-object v0
.end method

.method private static d()V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->stop()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    invoke-virtual {v1}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/aa;->r(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    const/4 v0, 0x0

    sput-boolean v0, Lchat/ola/vn/service/OlaVoiceChatService;->b:Z

    return-void
.end method

.method private e()Z
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->d:Ljava/util/List;

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->d:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_0

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->d:Ljava/util/List;

    invoke-interface {v1, v0}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/message/aa;

    sput-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    new-instance v1, Landroid/media/MediaPlayer;

    invoke-direct {v1}, Landroid/media/MediaPlayer;-><init>()V

    sput-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    invoke-virtual {v1}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_0

    sget-object v2, Lchat/ola/vn/service/OlaVoiceChatService;->e:Landroid/os/Handler;

    sget-object v3, Lchat/ola/vn/service/OlaVoiceChatService;->f:Ljava/lang/Runnable;

    invoke-virtual {v2, v3}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    new-instance v2, Ljava/io/FileInputStream;

    new-instance v3, Ljava/io/File;

    invoke-direct {v3, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v2}, Ljava/io/FileInputStream;->getFD()Ljava/io/FileDescriptor;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/media/MediaPlayer;->setDataSource(Ljava/io/FileDescriptor;)V

    invoke-virtual {v2}, Ljava/io/FileInputStream;->close()V

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v1, v0}, Landroid/media/MediaPlayer;->setLooping(Z)V

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v1, p0}, Landroid/media/MediaPlayer;->setOnPreparedListener(Landroid/media/MediaPlayer$OnPreparedListener;)V

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v1, p0}, Landroid/media/MediaPlayer;->setOnErrorListener(Landroid/media/MediaPlayer$OnErrorListener;)V

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v1, p0}, Landroid/media/MediaPlayer;->setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {p0}, Lchat/ola/vn/service/OlaVoiceChatService;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    const/4 v3, 0x1

    invoke-virtual {v1, v2, v3}, Landroid/media/MediaPlayer;->setWakeMode(Landroid/content/Context;I)V

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v1}, Landroid/media/MediaPlayer;->prepareAsync()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v3

    :catch_0
    move-exception v1

    invoke-virtual {v1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return v0
.end method

.method private f()V
    .locals 4

    invoke-static {p0}, Lchat/ola/vn/util/n;->d(Landroid/content/Context;)I

    move-result v0

    invoke-static {p0}, Lchat/ola/vn/util/n;->e(Landroid/content/Context;)I

    move-result v1

    mul-int/lit8 v1, v1, 0x5

    div-int/lit8 v1, v1, 0x64

    if-gt v0, v1, :cond_0

    const v0, 0x7f0f02c2

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, ""

    aput-object v3, v1, v2

    invoke-static {p0, v0, v1}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;I[Ljava/lang/Object;)V

    :cond_0
    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCompletion(Landroid/media/MediaPlayer;)V
    .locals 1

    :try_start_0
    sget-object p1, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    invoke-virtual {v0}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/aa;->r(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    invoke-direct {p0}, Lchat/ola/vn/service/OlaVoiceChatService;->e()Z

    move-result p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    sput-boolean p1, Lchat/ola/vn/service/OlaVoiceChatService;->b:Z

    invoke-virtual {p0}, Lchat/ola/vn/service/OlaVoiceChatService;->stopSelf()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_0
    return-void
.end method

.method public onDestroy()V
    .locals 3

    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_1

    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v1}, Landroid/media/MediaPlayer;->isPlaying()Z

    move-result v1

    if-eqz v1, :cond_0

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v1}, Landroid/media/MediaPlayer;->stop()V

    :cond_0
    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v1}, Landroid/media/MediaPlayer;->release()V

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->e:Landroid/os/Handler;

    sget-object v2, Lchat/ola/vn/service/OlaVoiceChatService;->f:Ljava/lang/Runnable;

    invoke-virtual {v1, v2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    sput-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->e:Landroid/os/Handler;

    sput-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v1

    sput-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    throw v1

    :catch_0
    :goto_0
    sput-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    :cond_1
    return-void
.end method

.method public onError(Landroid/media/MediaPlayer;II)Z
    .locals 0

    :try_start_0
    invoke-direct {p0}, Lchat/ola/vn/service/OlaVoiceChatService;->e()Z

    move-result p1

    if-nez p1, :cond_0

    const/4 p1, 0x0

    sput-boolean p1, Lchat/ola/vn/service/OlaVoiceChatService;->b:Z

    invoke-virtual {p0}, Lchat/ola/vn/service/OlaVoiceChatService;->stopSelf()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    const/4 p1, 0x1

    return p1
.end method

.method public onPrepared(Landroid/media/MediaPlayer;)V
    .locals 2

    sget-object p1, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->g:Lchat/ola/vn/message/aa;

    invoke-virtual {v0}, Lchat/ola/vn/message/aa;->a()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {v1}, Landroid/media/MediaPlayer;->getDuration()I

    move-result v1

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/message/aa;->a(Ljava/lang/String;I)V

    sget-object p1, Lchat/ola/vn/service/OlaVoiceChatService;->e:Landroid/os/Handler;

    sget-object v0, Lchat/ola/vn/service/OlaVoiceChatService;->f:Ljava/lang/Runnable;

    invoke-virtual {p1, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    sget-object p1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {p1}, Landroid/media/MediaPlayer;->start()V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/service/OlaVoiceChatService;->f()V

    sget-object p1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    :try_start_0
    sget-object p2, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    invoke-virtual {p2}, Landroid/media/MediaPlayer;->stop()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception p2

    sput-object p1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    throw p2

    :catch_0
    :goto_0
    sput-object p1, Lchat/ola/vn/service/OlaVoiceChatService;->a:Landroid/media/MediaPlayer;

    :cond_0
    sget-object p1, Lchat/ola/vn/service/OlaVoiceChatService;->e:Landroid/os/Handler;

    if-nez p1, :cond_1

    new-instance p1, Landroid/os/Handler;

    invoke-direct {p1}, Landroid/os/Handler;-><init>()V

    sput-object p1, Lchat/ola/vn/service/OlaVoiceChatService;->e:Landroid/os/Handler;

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/service/OlaVoiceChatService;->e()Z

    move-result p1

    if-nez p1, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/service/OlaVoiceChatService;->stopSelf()V

    :cond_2
    const/4 p1, 0x2

    return p1
.end method
