.class public Lchat/ola/vn/c/t;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/c/t$b;,
        Lchat/ola/vn/c/t$a;
    }
.end annotation


# static fields
.field public static a:Ljava/lang/Integer;

.field public static b:Lchat/ola/vn/c/t;


# instance fields
.field private c:Lchat/ola/vn/c/b;

.field private d:Lchat/ola/vn/c/b;

.field private e:Ljava/io/File;

.field private f:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/c/t$b;",
            ">;"
        }
    .end annotation
.end field

.field private g:Ljava/util/concurrent/Executor;

.field private h:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    return-void
.end method

.method private constructor <init>()V
    .locals 9

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/c/t;->g:Ljava/util/concurrent/Executor;

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/c/t;->h:I

    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Runtime;->maxMemory()J

    move-result-wide v0

    const-wide/16 v2, 0xf

    div-long v2, v0, v2

    long-to-int v2, v2

    const-wide/16 v3, 0x1e

    div-long/2addr v0, v3

    long-to-int v0, v0

    const/high16 v1, 0xa00000

    if-le v2, v1, :cond_0

    goto :goto_0

    :cond_0
    const/high16 v1, 0x180000

    if-ge v2, v1, :cond_1

    goto :goto_0

    :cond_1
    move v1, v2

    :goto_0
    const/high16 v2, 0x300000

    const/high16 v3, 0x80000

    if-le v0, v2, :cond_2

    const/high16 v0, 0x300000

    goto :goto_1

    :cond_2
    if-ge v0, v3, :cond_3

    const/high16 v0, 0x80000

    :cond_3
    :goto_1
    new-instance v2, Ljava/util/LinkedList;

    invoke-direct {v2}, Ljava/util/LinkedList;-><init>()V

    iput-object v2, p0, Lchat/ola/vn/c/t;->f:Ljava/util/List;

    invoke-static {}, Lcom/mg/ola/common/d/g;->d()Z

    move-result v2

    const/4 v3, 0x1

    if-eqz v2, :cond_4

    new-instance v2, Lchat/ola/vn/c/m;

    invoke-direct {v2, v1, v3}, Lchat/ola/vn/c/m;-><init>(IZ)V

    iput-object v2, p0, Lchat/ola/vn/c/t;->c:Lchat/ola/vn/c/b;

    new-instance v1, Lchat/ola/vn/c/m;

    invoke-direct {v1, v0, v3}, Lchat/ola/vn/c/m;-><init>(IZ)V

    :goto_2
    iput-object v1, p0, Lchat/ola/vn/c/t;->d:Lchat/ola/vn/c/b;

    goto :goto_3

    :cond_4
    new-instance v2, Lchat/ola/vn/c/j;

    invoke-direct {v2, v1, v3}, Lchat/ola/vn/c/j;-><init>(IZ)V

    iput-object v2, p0, Lchat/ola/vn/c/t;->c:Lchat/ola/vn/c/b;

    new-instance v1, Lchat/ola/vn/c/j;

    invoke-direct {v1, v0, v3}, Lchat/ola/vn/c/j;-><init>(IZ)V

    goto :goto_2

    :goto_3
    invoke-static {}, Lchat/ola/vn/d;->f()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_5

    new-instance v1, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v0

    const-string v2, ".cached"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    iput-object v1, p0, Lchat/ola/vn/c/t;->e:Ljava/io/File;

    iget-object v0, p0, Lchat/ola/vn/c/t;->e:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/c/t;->e:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->mkdir()Z

    :cond_5
    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v0

    if-eqz v0, :cond_6

    new-instance v0, Ljava/util/concurrent/ThreadPoolExecutor;

    const/4 v2, 0x1

    const/4 v3, 0x2

    const-wide/32 v4, 0xea60

    sget-object v6, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    new-instance v7, Ljava/util/concurrent/LinkedBlockingQueue;

    const/16 v1, 0x14

    invoke-direct {v7, v1}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>(I)V

    new-instance v8, Lchat/ola/vn/c/t$1;

    invoke-direct {v8, p0}, Lchat/ola/vn/c/t$1;-><init>(Lchat/ola/vn/c/t;)V

    move-object v1, v0

    invoke-direct/range {v1 .. v8}, Ljava/util/concurrent/ThreadPoolExecutor;-><init>(IIJLjava/util/concurrent/TimeUnit;Ljava/util/concurrent/BlockingQueue;Ljava/util/concurrent/ThreadFactory;)V

    iput-object v0, p0, Lchat/ola/vn/c/t;->g:Ljava/util/concurrent/Executor;

    :cond_6
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/c/t;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/c/t;->h:I

    return p0
.end method

.method public static a()Lchat/ola/vn/c/t;
    .locals 1

    sget-object v0, Lchat/ola/vn/c/t;->b:Lchat/ola/vn/c/t;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/c/t;

    invoke-direct {v0}, Lchat/ola/vn/c/t;-><init>()V

    sput-object v0, Lchat/ola/vn/c/t;->b:Lchat/ola/vn/c/t;

    :cond_0
    sget-object v0, Lchat/ola/vn/c/t;->b:Lchat/ola/vn/c/t;

    return-object v0
.end method

.method public static a(Lchat/ola/vn/view/OlaCachedImageView;Ljava/lang/String;Z)V
    .locals 4

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/pickercontacts/g;->b(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/c/f;->d:[I

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    aget v0, v0, v2

    invoke-virtual {p1, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    invoke-static {v2}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/pickercontacts/a;->a(Ljava/lang/Character;)Ljava/lang/String;

    move-result-object v2

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v3

    invoke-virtual {v3, v2}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v3

    if-nez v3, :cond_0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/c/f;->b(Ljava/lang/String;IZ)Landroid/graphics/Bitmap;

    move-result-object v3

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    invoke-virtual {p1, v2, v3}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Landroid/graphics/Bitmap;)Lchat/ola/vn/c/a;

    :cond_0
    if-eqz p2, :cond_1

    invoke-static {v3}, Lchat/ola/vn/c/f;->a(Landroid/graphics/Bitmap;)Landroid/graphics/Bitmap;

    move-result-object v3

    :cond_1
    const/4 p1, 0x0

    invoke-virtual {p0, v3, p1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method private a(Ljava/lang/String;ILchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Z)V
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    if-nez p3, :cond_1

    return-void

    :cond_1
    invoke-static {p1}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p2}, Lchat/ola/vn/c/f;->c(I)I

    move-result p2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, ".ccover."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v1, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    if-nez p5, :cond_2

    sget-object p1, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p3, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    return-void

    :cond_2
    invoke-virtual {p3, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    const/4 v1, 0x0

    invoke-virtual {p3, v1, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    new-instance v1, Lchat/ola/vn/c/k;

    invoke-direct {v1, p1, p3, p4, p2}, Lchat/ola/vn/c/k;-><init>(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;I)V

    :try_start_0
    new-instance p2, Lchat/ola/vn/c/t$7;

    invoke-direct {p2, p0, p5}, Lchat/ola/vn/c/t$7;-><init>(Lchat/ola/vn/c/t;Z)V

    new-instance p3, Lchat/ola/vn/c/t$a;

    invoke-direct {p3, p0}, Lchat/ola/vn/c/t$a;-><init>(Lchat/ola/vn/c/t;)V

    iput-object v1, p3, Lchat/ola/vn/c/t$a;->a:Lchat/ola/vn/c/w;

    iput-object v0, p3, Lchat/ola/vn/c/t$a;->c:Ljava/lang/String;

    iput-object p1, p3, Lchat/ola/vn/c/t$a;->d:Ljava/lang/String;

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p1

    const/4 p4, 0x0

    const/4 p5, 0x1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/c/t;->g:Ljava/util/concurrent/Executor;

    new-array p5, p5, [Lchat/ola/vn/c/t$a;

    aput-object p3, p5, p4

    invoke-virtual {p2, p1, p5}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_3
    sget-object p1, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v0, 0x5

    if-lt p1, v0, :cond_4

    :try_start_1
    new-instance p1, Lchat/ola/vn/c/t$b;

    invoke-direct {p1, p0}, Lchat/ola/vn/c/t$b;-><init>(Lchat/ola/vn/c/t;)V

    iput-object p2, p1, Lchat/ola/vn/c/t$b;->a:Landroid/os/AsyncTask;

    iput-object p3, p1, Lchat/ola/vn/c/t$b;->b:Lchat/ola/vn/c/t$a;

    iget-object p2, p0, Lchat/ola/vn/c/t;->f:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    return-void

    :cond_4
    :try_start_2
    new-array p1, p5, [Lchat/ola/vn/c/t$a;

    aput-object p3, p1, p4

    invoke-virtual {p2, p1}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method private a(Ljava/lang/String;ILchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;ZZ)V
    .locals 7
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    if-nez p3, :cond_1

    return-void

    :cond_1
    invoke-static {p2}, Lchat/ola/vn/c/f;->c(I)I

    move-result v5

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, ".cover."

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, "."

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p3, p2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object p1, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p3, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    return-void

    :cond_2
    invoke-virtual {p3, p2}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    const/4 v0, 0x0

    invoke-virtual {p3, v0, v0}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    new-instance v0, Lchat/ola/vn/c/u;

    move-object v1, v0

    move-object v2, p1

    move-object v3, p3

    move-object v4, p4

    move v6, p6

    invoke-direct/range {v1 .. v6}, Lchat/ola/vn/c/u;-><init>(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;IZ)V

    new-instance p3, Lchat/ola/vn/c/t$4;

    invoke-direct {p3, p0, p5}, Lchat/ola/vn/c/t$4;-><init>(Lchat/ola/vn/c/t;Z)V

    new-instance p4, Lchat/ola/vn/c/t$a;

    invoke-direct {p4, p0}, Lchat/ola/vn/c/t$a;-><init>(Lchat/ola/vn/c/t;)V

    iput-object v0, p4, Lchat/ola/vn/c/t$a;->a:Lchat/ola/vn/c/w;

    iput-object p2, p4, Lchat/ola/vn/c/t$a;->c:Ljava/lang/String;

    iput-object p1, p4, Lchat/ola/vn/c/t$a;->d:Ljava/lang/String;

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p1

    const/4 p2, 0x0

    const/4 p5, 0x1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/c/t;->g:Ljava/util/concurrent/Executor;

    new-array p5, p5, [Lchat/ola/vn/c/t$a;

    aput-object p4, p5, p2

    invoke-virtual {p3, p1, p5}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_3
    sget-object p1, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 p6, 0x5

    if-lt p1, p6, :cond_4

    :try_start_1
    new-instance p1, Lchat/ola/vn/c/t$b;

    invoke-direct {p1, p0}, Lchat/ola/vn/c/t$b;-><init>(Lchat/ola/vn/c/t;)V

    iput-object p3, p1, Lchat/ola/vn/c/t$b;->a:Landroid/os/AsyncTask;

    iput-object p4, p1, Lchat/ola/vn/c/t$b;->b:Lchat/ola/vn/c/t$a;

    iget-object p2, p0, Lchat/ola/vn/c/t;->f:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    return-void

    :cond_4
    :try_start_2
    new-array p1, p5, [Lchat/ola/vn/c/t$a;

    aput-object p4, p1, p2

    invoke-virtual {p3, p1}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method private a(Ljava/lang/String;IZLchat/ola/vn/view/OlaCachedImageView;IZ)V
    .locals 7
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    if-nez p4, :cond_1

    return-void

    :cond_1
    invoke-static {p1}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p2}, Lchat/ola/vn/c/f;->b(I)I

    move-result v5

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, ".covatar."

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, "."

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p4, p2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    if-nez p6, :cond_2

    sget-object p1, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p4, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    return-void

    :cond_2
    invoke-virtual {p4, p2}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    if-lez p5, :cond_3

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p4, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {p4, p5}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    goto :goto_0

    :cond_3
    const/4 p5, 0x0

    invoke-virtual {p4, p5, p5}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    :goto_0
    new-instance p5, Lchat/ola/vn/c/l;

    const/4 v4, 0x0

    move-object v1, p5

    move-object v2, p1

    move-object v3, p4

    move v6, p3

    invoke-direct/range {v1 .. v6}, Lchat/ola/vn/c/l;-><init>(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;IZ)V

    :try_start_0
    new-instance p3, Lchat/ola/vn/c/t$6;

    invoke-direct {p3, p0, p6}, Lchat/ola/vn/c/t$6;-><init>(Lchat/ola/vn/c/t;Z)V

    new-instance p4, Lchat/ola/vn/c/t$a;

    invoke-direct {p4, p0}, Lchat/ola/vn/c/t$a;-><init>(Lchat/ola/vn/c/t;)V

    iput-object p5, p4, Lchat/ola/vn/c/t$a;->a:Lchat/ola/vn/c/w;

    iput-object p2, p4, Lchat/ola/vn/c/t$a;->c:Ljava/lang/String;

    iput-object p1, p4, Lchat/ola/vn/c/t$a;->d:Ljava/lang/String;

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p1

    const/4 p2, 0x0

    const/4 p5, 0x1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/c/t;->g:Ljava/util/concurrent/Executor;

    new-array p5, p5, [Lchat/ola/vn/c/t$a;

    aput-object p4, p5, p2

    invoke-virtual {p3, p1, p5}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_4
    sget-object p1, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 p6, 0x5

    if-lt p1, p6, :cond_5

    :try_start_1
    new-instance p1, Lchat/ola/vn/c/t$b;

    invoke-direct {p1, p0}, Lchat/ola/vn/c/t$b;-><init>(Lchat/ola/vn/c/t;)V

    iput-object p3, p1, Lchat/ola/vn/c/t$b;->a:Landroid/os/AsyncTask;

    iput-object p4, p1, Lchat/ola/vn/c/t$b;->b:Lchat/ola/vn/c/t$a;

    iget-object p2, p0, Lchat/ola/vn/c/t;->f:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    return-void

    :cond_5
    :try_start_2
    new-array p1, p5, [Lchat/ola/vn/c/t$a;

    aput-object p4, p1, p2

    invoke-virtual {p3, p1}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method private a(Ljava/lang/String;IZLchat/ola/vn/view/OlaCachedImageView;Z)V
    .locals 7

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    if-nez p4, :cond_1

    return-void

    :cond_1
    invoke-static {p2}, Lchat/ola/vn/c/f;->b(I)I

    move-result v5

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, ".ovatar."

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, "."

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p4, p2}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    if-nez p5, :cond_2

    sget-object p1, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p4, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    return-void

    :cond_2
    invoke-virtual {p4, p2}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    const/4 v0, 0x0

    invoke-virtual {p4, v0, v0}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    new-instance v0, Lchat/ola/vn/c/v;

    const/4 v4, 0x0

    move-object v1, v0

    move-object v2, p1

    move-object v3, p4

    move v6, p3

    invoke-direct/range {v1 .. v6}, Lchat/ola/vn/c/v;-><init>(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;IZ)V

    invoke-direct {p0, p1, p5, p2, v0}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ZLjava/lang/String;Lchat/ola/vn/c/v;)V

    return-void
.end method

.method private a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/graphics/Bitmap;IZ)V
    .locals 7

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    if-nez p2, :cond_1

    return-void

    :cond_1
    invoke-static {p4}, Lchat/ola/vn/c/f;->b(I)I

    move-result v5

    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, ".ovatar."

    invoke-virtual {p4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p4, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v0, "."

    invoke-virtual {p4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p4

    invoke-virtual {p2, p4}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    if-nez p5, :cond_2

    sget-object p1, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p2, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    return-void

    :cond_2
    invoke-virtual {p2, p4}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    const/4 v0, 0x0

    if-eqz p3, :cond_3

    invoke-virtual {p2, p3, v0}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    invoke-virtual {p2, v0, v0}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    :goto_0
    new-instance p3, Lchat/ola/vn/c/v;

    const/4 v4, 0x0

    const/4 v6, 0x0

    move-object v1, p3

    move-object v2, p1

    move-object v3, p2

    invoke-direct/range {v1 .. v6}, Lchat/ola/vn/c/v;-><init>(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;IZ)V

    const/4 p2, 0x1

    invoke-virtual {p3, p2}, Lchat/ola/vn/c/v;->a(Z)V

    invoke-direct {p0, p1, p5, p4, p3}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ZLjava/lang/String;Lchat/ola/vn/c/v;)V

    return-void
.end method

.method private a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Landroid/graphics/Bitmap;IIIIZ)V
    .locals 9

    move-object v0, p1

    move-object v2, p2

    move-object v1, p4

    move v3, p5

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    return-void

    :cond_0
    if-nez v2, :cond_1

    return-void

    :cond_1
    invoke-virtual {v2, v0}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v2, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    return-void

    :cond_2
    const/4 v4, 0x0

    invoke-virtual {v2, v4, v4}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    if-eqz v1, :cond_3

    sget-object v3, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {v2, v1, v4}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    if-eqz v3, :cond_4

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v2, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {v2, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    :cond_4
    :goto_0
    invoke-virtual {v2, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    new-instance v8, Lchat/ola/vn/c/n;

    move-object v1, v8

    move-object v3, p3

    move v4, p6

    move/from16 v5, p7

    move/from16 v6, p8

    move/from16 v7, p9

    invoke-direct/range {v1 .. v7}, Lchat/ola/vn/c/n;-><init>(Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;IIIZ)V

    move-object v1, p0

    invoke-virtual {v1, v0, v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/c/w;)V

    return-void
.end method

.method private a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Landroid/graphics/Bitmap;IIZZ)V
    .locals 6

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    if-nez p2, :cond_1

    return-void

    :cond_1
    invoke-static {p1, p7}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object p7

    invoke-virtual {p2, p7}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    sget-object p1, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p2, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    return-void

    :cond_2
    const/4 v0, 0x0

    invoke-virtual {p2, v0, v0}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    if-eqz p4, :cond_3

    sget-object p5, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p2, p5}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {p2, p4, v0}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    if-eqz p5, :cond_4

    sget-object p4, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {p2, p4}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {p2, p5}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    :cond_4
    :goto_0
    invoke-virtual {p2, p7}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    new-instance p4, Lchat/ola/vn/c/p;

    move-object v0, p4

    move-object v1, p2

    move-object v2, p3

    move-object v3, p1

    move v4, p6

    move v5, p8

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/c/p;-><init>(Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Ljava/lang/String;IZ)V

    invoke-virtual {p0, p1, p7, p4}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/c/c;)V

    return-void
.end method

.method private a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;Landroid/graphics/Bitmap;IIZ)V
    .locals 10

    move-object v2, p2

    move-object v4, p4

    move-object v0, p5

    move/from16 v1, p6

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    return-void

    :cond_0
    if-nez v2, :cond_1

    return-void

    :cond_1
    :try_start_0
    move-object v3, v2

    check-cast v3, Lchat/ola/vn/view/OlaRatioImageView;

    invoke-static {p1}, Lchat/ola/vn/entity/i;->b(Ljava/lang/String;)[I

    move-result-object v5

    const/4 v6, 0x0

    aget v6, v5, v6

    int-to-double v6, v6

    const/4 v8, 0x1

    aget v5, v5, v8

    int-to-double v8, v5

    div-double/2addr v6, v8

    invoke-virtual {v3, v6, v7}, Lchat/ola/vn/view/OlaRatioImageView;->setRatio(D)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    move-object v5, p1

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, "_"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static/range {p7 .. p7}, Lchat/ola/vn/c/f;->a(I)I

    move-result v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v2, v7}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    if-eqz v4, :cond_2

    const/16 v0, 0x8

    invoke-virtual {v4, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_2
    invoke-virtual {v2, p3}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    return-void

    :cond_3
    const/4 v3, 0x0

    invoke-virtual {v2, v3, v3}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    if-eqz v0, :cond_4

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v2, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {v2, v0, v3}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    goto :goto_0

    :cond_4
    if-eqz v1, :cond_5

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v2, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {v2, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    :cond_5
    :goto_0
    invoke-virtual {v2, v7}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    new-instance v8, Lchat/ola/vn/c/r;

    move-object v0, v8

    move-object v1, v5

    move-object v3, p3

    move/from16 v5, p7

    move/from16 v6, p8

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/c/r;-><init>(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;IZ)V

    move-object v0, p0

    invoke-virtual {v0, v7, v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/c/w;)V

    return-void
.end method

.method private a(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;Landroid/graphics/Bitmap;IIIIZ)V
    .locals 10

    move-object v0, p1

    move-object v2, p2

    move-object v1, p5

    move/from16 v3, p6

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    return-void

    :cond_0
    if-nez v2, :cond_1

    return-void

    :cond_1
    invoke-virtual {v2, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v2, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    return-void

    :cond_2
    const/4 v4, 0x0

    invoke-virtual {v2, v4, v4}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    if-eqz v1, :cond_3

    sget-object v3, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v2, v3}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {v2, v1, v4}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    if-eqz v3, :cond_4

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v2, v1}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {v2, v3}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setImageResource(I)V

    :cond_4
    :goto_0
    invoke-virtual {v2, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setLoadingUrl(Ljava/lang/String;)V

    new-instance v9, Lchat/ola/vn/c/o;

    move-object v1, v9

    move-object v3, p3

    move-object v4, p4

    move/from16 v5, p7

    move/from16 v6, p8

    move/from16 v7, p9

    move/from16 v8, p10

    invoke-direct/range {v1 .. v8}, Lchat/ola/vn/c/o;-><init>(Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;IIIZ)V

    move-object v1, p0

    invoke-virtual {v1, v0, v9}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/c/w;)V

    return-void
.end method

.method private a(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;Landroid/graphics/Bitmap;IIZ)V
    .locals 9

    move-object v2, p2

    move-object v0, p5

    move v1, p6

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    return-void

    :cond_0
    if-nez v2, :cond_1

    return-void

    :cond_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    move-object v4, p1

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, "_"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static/range {p7 .. p7}, Lchat/ola/vn/c/f;->a(I)I

    move-result v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v2, v7}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v2, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    return-void

    :cond_2
    const/4 v3, 0x0

    invoke-virtual {v2, v3, v3}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    if-eqz v0, :cond_3

    sget-object v1, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v2, v1}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {v2, v0, v3}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    if-eqz v1, :cond_4

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v2, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {v2, v1}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setImageResource(I)V

    :cond_4
    :goto_0
    invoke-virtual {v2, v7}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setLoadingUrl(Ljava/lang/String;)V

    new-instance v8, Lchat/ola/vn/c/s;

    move-object v0, v8

    move-object v1, v4

    move-object v3, p3

    move-object v4, p4

    move/from16 v5, p7

    move/from16 v6, p8

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/c/s;-><init>(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;IZ)V

    move-object v0, p0

    invoke-virtual {v0, v7, v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/c/w;)V

    return-void
.end method

.method private a(Ljava/lang/String;ZLjava/lang/String;Lchat/ola/vn/c/v;)V
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    :try_start_0
    new-instance v0, Lchat/ola/vn/c/t$5;

    invoke-direct {v0, p0, p2}, Lchat/ola/vn/c/t$5;-><init>(Lchat/ola/vn/c/t;Z)V

    new-instance p2, Lchat/ola/vn/c/t$a;

    invoke-direct {p2, p0}, Lchat/ola/vn/c/t$a;-><init>(Lchat/ola/vn/c/t;)V

    iput-object p4, p2, Lchat/ola/vn/c/t$a;->a:Lchat/ola/vn/c/w;

    iput-object p3, p2, Lchat/ola/vn/c/t$a;->c:Ljava/lang/String;

    iput-object p1, p2, Lchat/ola/vn/c/t$a;->d:Ljava/lang/String;

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p1

    const/4 p3, 0x0

    const/4 p4, 0x1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/c/t;->g:Ljava/util/concurrent/Executor;

    new-array p4, p4, [Lchat/ola/vn/c/t$a;

    aput-object p2, p4, p3

    invoke-virtual {v0, p1, p4}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v1, 0x5

    if-lt p1, v1, :cond_1

    :try_start_1
    new-instance p1, Lchat/ola/vn/c/t$b;

    invoke-direct {p1, p0}, Lchat/ola/vn/c/t$b;-><init>(Lchat/ola/vn/c/t;)V

    iput-object v0, p1, Lchat/ola/vn/c/t$b;->a:Landroid/os/AsyncTask;

    iput-object p2, p1, Lchat/ola/vn/c/t$b;->b:Lchat/ola/vn/c/t$a;

    iget-object p2, p0, Lchat/ola/vn/c/t;->f:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    return-void

    :cond_1
    :try_start_2
    new-array p1, p4, [Lchat/ola/vn/c/t$a;

    aput-object p2, p1, p3

    invoke-virtual {v0, p1}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/c/t;)I
    .locals 1

    iget v0, p0, Lchat/ola/vn/c/t;->h:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lchat/ola/vn/c/t;->h:I

    return v0
.end method

.method public static b(Ljava/lang/String;Z)Ljava/lang/String;
    .locals 1

    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object p0

    const/4 v0, 0x3

    invoke-static {p0, v0}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object p0

    if-eqz p1, :cond_0

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v0, ".thumb."

    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    :cond_0
    return-object p0
.end method

.method private b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/graphics/Bitmap;I)V
    .locals 2

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    if-nez p2, :cond_1

    return-void

    :cond_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {p4}, Lchat/ola/vn/c/f;->a(I)I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/view/OlaCachedImageView;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    return-void

    :cond_2
    const/4 v1, 0x0

    invoke-virtual {p2, p3, v1}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    invoke-virtual {p2, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setLoadingUrl(Ljava/lang/String;)V

    new-instance p3, Lchat/ola/vn/c/h;

    invoke-direct {p3, p1, p2, p4}, Lchat/ola/vn/c/h;-><init>(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V

    invoke-virtual {p0, v0, p3}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/c/w;)V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/c/t;)Ljava/util/List;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/c/t;->f:Ljava/util/List;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/c/t;)Lchat/ola/vn/c/b;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/c/t;->c:Lchat/ola/vn/c/b;

    return-object p0
.end method

.method static synthetic e(Lchat/ola/vn/c/t;)Lchat/ola/vn/c/b;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/c/t;->d:Lchat/ola/vn/c/b;

    return-object p0
.end method


# virtual methods
.method public a(Ljava/lang/String;Z)Landroid/graphics/Bitmap;
    .locals 2

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    :try_start_0
    invoke-static {p1, p2}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p0, p1}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    return-object v1
.end method

.method public a(Ljava/lang/String;)Lchat/ola/vn/c/a;
    .locals 4

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 p1, 0x0

    return-object p1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/c/t;->c:Lchat/ola/vn/c/b;

    invoke-virtual {v0, p1}, Lchat/ola/vn/c/b;->a(Ljava/lang/String;)Lchat/ola/vn/c/a;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-boolean v1, v0, Lchat/ola/vn/c/a;->d:Z

    if-eqz v1, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/c/a;->c:J

    return-object v0

    :cond_1
    :try_start_0
    new-instance v1, Ljava/io/File;

    iget-object v2, p0, Lchat/ola/vn/c/t;->e:Ljava/io/File;

    invoke-virtual {v2}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v2

    const-string v3, ".best"

    invoke-direct {v1, v2, v3}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_3

    new-instance v2, Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v1

    invoke-direct {v2, v1, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v1, :cond_3

    :try_start_1
    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Landroid/graphics/BitmapFactory;->decodeFile(Ljava/lang/String;)Landroid/graphics/Bitmap;

    move-result-object v1

    if-eqz v1, :cond_2

    const/4 v2, 0x1

    invoke-virtual {p0, p1, v1, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Landroid/graphics/Bitmap;Z)Lchat/ola/vn/c/a;

    move-result-object p1

    return-object p1

    :cond_2
    if-nez v1, :cond_3

    invoke-virtual {p0}, Lchat/ola/vn/c/t;->b()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    return-object v0

    :catch_0
    :try_start_2
    invoke-virtual {p0}, Lchat/ola/vn/c/t;->b()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_3
    return-object v0
.end method

.method public a(Ljava/lang/String;Landroid/graphics/Bitmap;)Lchat/ola/vn/c/a;
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Landroid/graphics/Bitmap;Z)Lchat/ola/vn/c/a;

    move-result-object p1

    return-object p1
.end method

.method public a(Ljava/lang/String;Landroid/graphics/Bitmap;Z)Lchat/ola/vn/c/a;
    .locals 3

    if-eqz p1, :cond_1

    if-nez p2, :cond_0

    goto :goto_0

    :cond_0
    new-instance v0, Lchat/ola/vn/c/a;

    invoke-direct {v0}, Lchat/ola/vn/c/a;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/c/a;->c:J

    iput-object p2, v0, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;

    iput-object p1, v0, Lchat/ola/vn/c/a;->b:Ljava/lang/String;

    iput-boolean p3, v0, Lchat/ola/vn/c/a;->d:Z

    iget-object p2, p0, Lchat/ola/vn/c/t;->c:Lchat/ola/vn/c/b;

    invoke-virtual {p2, p1, v0}, Lchat/ola/vn/c/b;->a(Ljava/lang/String;Lchat/ola/vn/c/a;)Lchat/ola/vn/c/a;

    return-object v0

    :cond_1
    :goto_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/c/w;)V
    .locals 4
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    :try_start_0
    new-instance v0, Lchat/ola/vn/c/t$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/c/t$3;-><init>(Lchat/ola/vn/c/t;)V

    new-instance v1, Lchat/ola/vn/c/t$a;

    invoke-direct {v1, p0}, Lchat/ola/vn/c/t$a;-><init>(Lchat/ola/vn/c/t;)V

    iput-object p2, v1, Lchat/ola/vn/c/t$a;->a:Lchat/ola/vn/c/w;

    iput-object p1, v1, Lchat/ola/vn/c/t$a;->c:Ljava/lang/String;

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p1

    const/4 p2, 0x0

    const/4 v2, 0x1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/c/t;->g:Ljava/util/concurrent/Executor;

    new-array v2, v2, [Lchat/ola/vn/c/t$a;

    aput-object v1, v2, p2

    invoke-virtual {v0, p1, v2}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v3, 0x5

    if-lt p1, v3, :cond_1

    :try_start_1
    new-instance p1, Lchat/ola/vn/c/t$b;

    invoke-direct {p1, p0}, Lchat/ola/vn/c/t$b;-><init>(Lchat/ola/vn/c/t;)V

    iput-object v0, p1, Lchat/ola/vn/c/t$b;->a:Landroid/os/AsyncTask;

    iput-object v1, p1, Lchat/ola/vn/c/t$b;->b:Lchat/ola/vn/c/t$a;

    iget-object p2, p0, Lchat/ola/vn/c/t;->f:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    return-void

    :cond_1
    :try_start_2
    new-array p1, v2, [Lchat/ola/vn/c/t$a;

    aput-object v1, p1, p2

    invoke-virtual {v0, p1}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 9

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    invoke-direct/range {v0 .. v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Landroid/graphics/Bitmap;IIZZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V
    .locals 9

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v7, 0x1

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v6, p3

    invoke-direct/range {v0 .. v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Landroid/graphics/Bitmap;IIZZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;II)V
    .locals 9

    sget-object v3, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v6, p3

    move v7, p4

    invoke-direct/range {v0 .. v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;Landroid/graphics/Bitmap;IIZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;IIZ)V
    .locals 9

    sget-object v3, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v6, p3

    move v7, p4

    move v8, p5

    invoke-direct/range {v0 .. v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;Landroid/graphics/Bitmap;IIZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;IZ)V
    .locals 9

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x1

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v5, p3

    move v8, p4

    invoke-direct/range {v0 .. v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Landroid/graphics/Bitmap;IIZZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/graphics/Bitmap;)V
    .locals 6

    const/16 v4, 0xc8

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/graphics/Bitmap;IZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/graphics/Bitmap;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/graphics/Bitmap;I)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;)V
    .locals 9

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x1

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    invoke-direct/range {v0 .. v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Landroid/graphics/Bitmap;IIZZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;I)V
    .locals 10

    sget v0, Lchat/ola/vn/e;->c:I

    sget v1, Lchat/ola/vn/e;->d:I

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    mul-int/lit8 v0, v0, 0x2

    sget-boolean v1, Lchat/ola/vn/h;->I:Z

    if-eqz v1, :cond_0

    sget v0, Lchat/ola/vn/e;->c:I

    sget v1, Lchat/ola/vn/e;->d:I

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    const/16 v1, 0x780

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    :cond_0
    move v8, v0

    sget-object v4, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    const/4 v6, 0x0

    const/4 v9, 0x0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v5, p3

    move v7, p4

    invoke-direct/range {v1 .. v9}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;Landroid/graphics/Bitmap;IIZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;II)V
    .locals 10

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v9, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v7, p4

    move v8, p5

    invoke-direct/range {v0 .. v9}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Landroid/graphics/Bitmap;IIIIZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;I)V
    .locals 9

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move v7, p5

    invoke-direct/range {v0 .. v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;Landroid/graphics/Bitmap;IIZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Z)V
    .locals 9

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v7, p3

    invoke-direct/range {v0 .. v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Landroid/graphics/Bitmap;IIZZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;)V
    .locals 6

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;I)V

    return-void
.end method

.method public a(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;I)V
    .locals 10

    const/4 v5, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move v6, p5

    invoke-virtual/range {v0 .. v9}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;Landroid/graphics/Bitmap;IIZZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;II)V
    .locals 11

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v10, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move/from16 v8, p5

    move/from16 v9, p6

    invoke-direct/range {v0 .. v10}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;Landroid/graphics/Bitmap;IIIIZ)V

    return-void
.end method

.method public a(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;Landroid/graphics/Bitmap;IIZZ)V
    .locals 10

    move-object v7, p1

    move-object v1, p2

    move-object v0, p5

    move/from16 v2, p6

    invoke-static {v7}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    return-void

    :cond_0
    if-nez v1, :cond_1

    return-void

    :cond_1
    move/from16 v3, p8

    invoke-static {v7, v3}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Z)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v1, v8}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v1, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    return-void

    :cond_2
    const/4 v3, 0x0

    invoke-virtual {v1, v3, v3}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    if-eqz v0, :cond_3

    sget-object v2, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {v1, v0, v3}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    goto :goto_0

    :cond_3
    if-eqz v2, :cond_4

    sget-object v0, Landroid/widget/ImageView$ScaleType;->CENTER_INSIDE:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v1, v0}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    invoke-virtual {v1, v2}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setImageResource(I)V

    :cond_4
    :goto_0
    invoke-virtual {v1, v8}, Lcom/mg/ola/common/widget/image/viewer/PhotoView;->setLoadingUrl(Ljava/lang/String;)V

    new-instance v9, Lchat/ola/vn/c/q;

    move-object v0, v9

    move-object v2, p3

    move-object v3, p4

    move-object v4, v7

    move/from16 v5, p7

    move/from16 v6, p9

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/c/q;-><init>(Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;Ljava/lang/String;IZ)V

    move-object v0, p0

    invoke-virtual {v0, v7, v8, v9}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/c/c;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/c/t;->c:Lchat/ola/vn/c/b;

    invoke-virtual {v0, p1}, Lchat/ola/vn/c/b;->b(Ljava/lang/String;)Lchat/ola/vn/c/a;

    move-result-object p1

    if-eqz p1, :cond_0

    iput-object p2, p1, Lchat/ola/vn/c/a;->b:Ljava/lang/String;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p1, Lchat/ola/vn/c/a;->c:J

    iget-object v0, p0, Lchat/ola/vn/c/t;->c:Lchat/ola/vn/c/b;

    invoke-virtual {v0, p2, p1}, Lchat/ola/vn/c/b;->a(Ljava/lang/String;Lchat/ola/vn/c/a;)Lchat/ola/vn/c/a;

    :cond_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/c/c;)V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    :try_start_0
    new-instance v0, Lchat/ola/vn/c/t$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/c/t$2;-><init>(Lchat/ola/vn/c/t;)V

    new-instance v1, Lchat/ola/vn/c/t$a;

    invoke-direct {v1, p0}, Lchat/ola/vn/c/t$a;-><init>(Lchat/ola/vn/c/t;)V

    iput-object p3, v1, Lchat/ola/vn/c/t$a;->a:Lchat/ola/vn/c/w;

    iput-object p2, v1, Lchat/ola/vn/c/t$a;->c:Ljava/lang/String;

    iput-object p1, v1, Lchat/ola/vn/c/t$a;->b:Ljava/lang/String;

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p1

    const/4 p2, 0x0

    const/4 p3, 0x1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/c/t;->g:Ljava/util/concurrent/Executor;

    new-array p3, p3, [Lchat/ola/vn/c/t$a;

    aput-object v1, p3, p2

    invoke-virtual {v0, p1, p3}, Landroid/os/AsyncTask;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_0
    sget-object p1, Lchat/ola/vn/c/t;->a:Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v2, 0x5

    if-lt p1, v2, :cond_1

    :try_start_1
    new-instance p1, Lchat/ola/vn/c/t$b;

    invoke-direct {p1, p0}, Lchat/ola/vn/c/t$b;-><init>(Lchat/ola/vn/c/t;)V

    iput-object v0, p1, Lchat/ola/vn/c/t$b;->a:Landroid/os/AsyncTask;

    iput-object v1, p1, Lchat/ola/vn/c/t$b;->b:Lchat/ola/vn/c/t$a;

    iget-object p2, p0, Lchat/ola/vn/c/t;->f:Ljava/util/List;

    invoke-interface {p2, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    return-void

    :cond_1
    :try_start_2
    new-array p1, p3, [Lchat/ola/vn/c/t$a;

    aput-object v1, p1, p2

    invoke-virtual {v0, p1}, Landroid/os/AsyncTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method public a(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;)V
    .locals 6

    const/16 v2, 0xc8

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move v3, p2

    move-object v4, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;IZLchat/ola/vn/view/OlaCachedImageView;Z)V

    return-void
.end method

.method public a(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;Z)V
    .locals 6

    const/16 v2, 0xc8

    move-object v0, p0

    move-object v1, p1

    move v3, p2

    move-object v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;IZLchat/ola/vn/view/OlaCachedImageView;Z)V

    return-void
.end method

.method public a(Z)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/t;->c:Lchat/ola/vn/c/b;

    invoke-virtual {v0}, Lchat/ola/vn/c/b;->a()V

    if-eqz p1, :cond_0

    invoke-static {}, Lchat/ola/vn/network/OlaNetworkService;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b(Ljava/lang/String;)Landroid/graphics/Bitmap;
    .locals 2

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/c/t;->c:Lchat/ola/vn/c/b;

    invoke-virtual {v0, p1}, Lchat/ola/vn/c/b;->a(Ljava/lang/String;)Lchat/ola/vn/c/a;

    move-result-object p1

    if-eqz p1, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p1, Lchat/ola/vn/c/a;->c:J

    iget-object p1, p1, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;

    return-object p1

    :cond_1
    return-object v1
.end method

.method public b(Ljava/lang/String;Landroid/graphics/Bitmap;)Lchat/ola/vn/c/a;
    .locals 3

    if-eqz p1, :cond_1

    if-nez p2, :cond_0

    goto :goto_0

    :cond_0
    new-instance v0, Lchat/ola/vn/c/a;

    invoke-direct {v0}, Lchat/ola/vn/c/a;-><init>()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/c/a;->c:J

    iput-object p2, v0, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;

    iput-object p1, v0, Lchat/ola/vn/c/a;->b:Ljava/lang/String;

    const/4 p2, 0x0

    iput-boolean p2, v0, Lchat/ola/vn/c/a;->d:Z

    iget-object p2, p0, Lchat/ola/vn/c/t;->d:Lchat/ola/vn/c/b;

    invoke-virtual {p2, p1, v0}, Lchat/ola/vn/c/b;->a(Ljava/lang/String;Lchat/ola/vn/c/a;)Lchat/ola/vn/c/a;

    return-object v0

    :cond_1
    :goto_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public b()V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/c/t;->a(Z)V

    return-void
.end method

.method public b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 9

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    invoke-direct/range {v0 .. v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Landroid/graphics/Bitmap;IIZZ)V

    return-void
.end method

.method public b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V
    .locals 9

    sget-object v3, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v7, p3

    invoke-direct/range {v0 .. v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;Landroid/graphics/Bitmap;IIZ)V

    return-void
.end method

.method public b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;)V
    .locals 9

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    invoke-direct/range {v0 .. v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Landroid/graphics/Bitmap;IIZZ)V

    return-void
.end method

.method public b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;I)V
    .locals 6

    sget-object v3, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, p3

    move v5, p4

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;I)V

    return-void
.end method

.method public b(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Z)V
    .locals 7

    const/16 v2, 0x2d0

    const/4 v4, 0x0

    const/4 v6, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move v5, p3

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ILchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;ZZ)V

    return-void
.end method

.method public b(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;)V
    .locals 6

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;I)V

    return-void
.end method

.method public b(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;I)V
    .locals 10

    sget v0, Lchat/ola/vn/e;->c:I

    sget v1, Lchat/ola/vn/e;->d:I

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    mul-int/lit8 v0, v0, 0x2

    sget-boolean v1, Lchat/ola/vn/h;->I:Z

    if-eqz v1, :cond_0

    sget v0, Lchat/ola/vn/e;->c:I

    sget v1, Lchat/ola/vn/e;->d:I

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    const/16 v1, 0x780

    invoke-static {v0, v1}, Ljava/lang/Math;->max(II)I

    move-result v0

    :cond_0
    move v8, v0

    const/4 v6, 0x0

    const/4 v9, 0x0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-object v5, p4

    move v7, p5

    invoke-direct/range {v1 .. v9}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lcom/mg/ola/common/widget/image/viewer/PhotoView;Landroid/widget/ImageView$ScaleType;Landroid/view/View;Landroid/graphics/Bitmap;IIZ)V

    return-void
.end method

.method public b(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;)V
    .locals 6

    const/16 v2, 0x64

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move v3, p2

    move-object v4, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;IZLchat/ola/vn/view/OlaCachedImageView;Z)V

    return-void
.end method

.method public b(Z)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c/t;->d:Lchat/ola/vn/c/b;

    invoke-virtual {v0}, Lchat/ola/vn/c/b;->a()V

    if-eqz p1, :cond_0

    invoke-static {}, Lchat/ola/vn/network/OlaNetworkService;->b()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public c(Ljava/lang/String;)Landroid/graphics/Bitmap;
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    return-object v0

    :cond_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ".ovatar.100."

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v1, p0, Lchat/ola/vn/c/t;->d:Lchat/ola/vn/c/b;

    invoke-virtual {v1, p1}, Lchat/ola/vn/c/b;->a(Ljava/lang/String;)Lchat/ola/vn/c/a;

    move-result-object p1

    if-eqz p1, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iput-wide v1, p1, Lchat/ola/vn/c/a;->c:J

    iget-object p1, p1, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_1
    return-object v0
.end method

.method public c()V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lchat/ola/vn/c/t;->b(Z)V

    return-void
.end method

.method public c(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 9

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x1

    const/4 v8, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    invoke-direct/range {v0 .. v8}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Landroid/graphics/Bitmap;IIZZ)V

    return-void
.end method

.method public c(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;I)V
    .locals 10

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v6, 0x2

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v5, p3

    invoke-direct/range {v0 .. v9}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Landroid/graphics/Bitmap;IIIIZ)V

    return-void
.end method

.method public c(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, p3, v0}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;I)V

    return-void
.end method

.method public c(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Z)V
    .locals 7

    const/16 v2, 0x2d0

    const/4 v4, 0x0

    const/4 v6, 0x1

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move v5, p3

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ILchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;ZZ)V

    return-void
.end method

.method public d(Ljava/lang/String;)Landroid/graphics/Bitmap;
    .locals 3

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return-object v1

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, ".cover."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/c/t;->c:Lchat/ola/vn/c/b;

    invoke-virtual {v0, p1}, Lchat/ola/vn/c/b;->a(Ljava/lang/String;)Lchat/ola/vn/c/a;

    move-result-object p1

    if-eqz p1, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p1, Lchat/ola/vn/c/a;->c:J

    iget-object p1, p1, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;

    return-object p1

    :cond_1
    return-object v1
.end method

.method public d(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, p2, v0, v1}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;I)V

    return-void
.end method

.method public d(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Z)V
    .locals 6

    const/16 v2, 0x2d0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    move v5, p3

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ILchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Z)V

    return-void
.end method

.method public e(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 10

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x1

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    invoke-direct/range {v0 .. v9}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;Landroid/graphics/Bitmap;IIIIZ)V

    return-void
.end method

.method public e(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Z)V
    .locals 7

    const/16 v2, 0xc8

    const/4 v3, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v4, p2

    move v6, p3

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;IZLchat/ola/vn/view/OlaCachedImageView;IZ)V

    return-void
.end method

.method public f(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 6

    const/16 v2, 0x32

    const/4 v3, 0x1

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v4, p2

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;IZLchat/ola/vn/view/OlaCachedImageView;Z)V

    return-void
.end method

.method public g(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 6

    const/16 v2, 0x64

    const/4 v3, 0x1

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v4, p2

    invoke-direct/range {v0 .. v5}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;IZLchat/ola/vn/view/OlaCachedImageView;Z)V

    return-void
.end method

.method public h(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 7

    const/16 v2, 0x1e0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x1

    move-object v0, p0

    move-object v1, p1

    move-object v3, p2

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ILchat/ola/vn/view/OlaCachedImageView;Landroid/view/View;ZZ)V

    return-void
.end method

.method public i(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lchat/ola/vn/c/t;->e(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;Z)V

    return-void
.end method

.method public j(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 7

    const/16 v2, 0x64

    const/4 v3, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v4, p2

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;IZLchat/ola/vn/view/OlaCachedImageView;IZ)V

    return-void
.end method

.method public k(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V
    .locals 7

    const/16 v2, 0x32

    const/4 v3, 0x1

    const v5, 0x7f08071c

    const/4 v6, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v4, p2

    invoke-direct/range {v0 .. v6}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;IZLchat/ola/vn/view/OlaCachedImageView;IZ)V

    return-void
.end method
