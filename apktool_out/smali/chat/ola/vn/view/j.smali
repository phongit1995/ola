.class public Lchat/ola/vn/view/j;
.super Lchat/ola/vn/view/d;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/j$a;
    }
.end annotation


# instance fields
.field a:Landroid/media/MediaRecorder;

.field b:Lchat/ola/vn/view/OlaAttachmentVoiceButton;

.field c:Landroid/widget/TextView;

.field d:Landroid/widget/TextView;

.field e:Landroid/widget/TextView;

.field public f:Landroid/widget/TextView;

.field protected g:Lchat/ola/vn/view/j$a;

.field private h:Landroid/view/animation/Animation;

.field private i:Landroid/view/animation/Animation;

.field private j:Landroid/os/Handler;

.field private k:Ljava/lang/String;

.field private l:J

.field private m:Ljava/lang/Runnable;

.field private n:Ljava/io/File;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    invoke-direct {p0, p1}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    const-string v1, "0:00"

    iput-object v1, p0, Lchat/ola/vn/view/j;->k:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/view/j;->f:Landroid/widget/TextView;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/view/j;->l:J

    new-instance v0, Lchat/ola/vn/view/j$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/view/j$1;-><init>(Lchat/ola/vn/view/j;)V

    iput-object v0, p0, Lchat/ola/vn/view/j;->m:Ljava/lang/Runnable;

    invoke-direct {p0, p1}, Lchat/ola/vn/view/j;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p2, 0x0

    iput-object p2, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    const-string v0, "0:00"

    iput-object v0, p0, Lchat/ola/vn/view/j;->k:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/view/j;->f:Landroid/widget/TextView;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/view/j;->l:J

    new-instance p2, Lchat/ola/vn/view/j$1;

    invoke-direct {p2, p0}, Lchat/ola/vn/view/j$1;-><init>(Lchat/ola/vn/view/j;)V

    iput-object p2, p0, Lchat/ola/vn/view/j;->m:Ljava/lang/Runnable;

    invoke-direct {p0, p1}, Lchat/ola/vn/view/j;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p2, 0x0

    iput-object p2, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    const-string p3, "0:00"

    iput-object p3, p0, Lchat/ola/vn/view/j;->k:Ljava/lang/String;

    iput-object p2, p0, Lchat/ola/vn/view/j;->f:Landroid/widget/TextView;

    const-wide/16 p2, 0x0

    iput-wide p2, p0, Lchat/ola/vn/view/j;->l:J

    new-instance p2, Lchat/ola/vn/view/j$1;

    invoke-direct {p2, p0}, Lchat/ola/vn/view/j$1;-><init>(Lchat/ola/vn/view/j;)V

    iput-object p2, p0, Lchat/ola/vn/view/j;->m:Ljava/lang/Runnable;

    invoke-direct {p0, p1}, Lchat/ola/vn/view/j;->a(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/view/j;)J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/view/j;->l:J

    return-wide v0
.end method

.method static synthetic a(Lchat/ola/vn/view/j;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/j;->k:Ljava/lang/String;

    return-object p1
.end method

.method private a(Landroid/content/Context;)V
    .locals 3

    const v0, 0x7f0b013c

    invoke-static {p1, v0, p0}, Lchat/ola/vn/view/j;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    const v0, 0x7f010024

    :try_start_0
    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/view/j;->h:Landroid/view/animation/Animation;

    iget-object v0, p0, Lchat/ola/vn/view/j;->h:Landroid/view/animation/Animation;

    const-wide/16 v1, 0x12c

    invoke-virtual {v0, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    const v0, 0x7f010021

    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/view/j;->i:Landroid/view/animation/Animation;

    iget-object p1, p0, Lchat/ola/vn/view/j;->i:Landroid/view/animation/Animation;

    invoke-virtual {p1, v1, v2}, Landroid/view/animation/Animation;->setDuration(J)V

    const p1, 0x7f09040c

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/j;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaAttachmentVoiceButton;

    iput-object p1, p0, Lchat/ola/vn/view/j;->b:Lchat/ola/vn/view/OlaAttachmentVoiceButton;

    const p1, 0x7f09040d

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/j;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/view/j;->d:Landroid/widget/TextView;

    const p1, 0x7f09040e

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/j;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/view/j;->c:Landroid/widget/TextView;

    const p1, 0x7f09040f

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/j;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/view/j;->b:Lchat/ola/vn/view/OlaAttachmentVoiceButton;

    iput-object p0, p1, Lchat/ola/vn/view/OlaAttachmentVoiceButton;->a:Lchat/ola/vn/view/OlaAttachmentVoiceButton$a;

    new-instance p1, Landroid/os/Handler;

    invoke-direct {p1}, Landroid/os/Handler;-><init>()V

    iput-object p1, p0, Lchat/ola/vn/view/j;->j:Landroid/os/Handler;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/view/j;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/j;->k:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/view/j;)Ljava/lang/Runnable;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/j;->m:Ljava/lang/Runnable;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/view/j;)Landroid/os/Handler;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/view/j;->j:Landroid/os/Handler;

    return-object p0
.end method

.method private h()V
    .locals 5
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "InlinedApi"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/view/j;->j:Landroid/os/Handler;

    iget-object v1, p0, Lchat/ola/vn/view/j;->m:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    new-instance v0, Landroid/media/MediaRecorder;

    invoke-direct {v0}, Landroid/media/MediaRecorder;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    iget-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setAudioSource(I)V

    iget-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    const/4 v2, 0x2

    invoke-virtual {v0, v2}, Landroid/media/MediaRecorder;->setOutputFormat(I)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->b()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    const/4 v1, 0x3

    :goto_0
    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setAudioEncoder(I)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    goto :goto_0

    :goto_1
    new-instance v0, Ljava/io/File;

    invoke-static {}, Lchat/ola/vn/d;->a()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ".record."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string v3, ".tmp"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v0, p0, Lchat/ola/vn/view/j;->n:Ljava/io/File;

    iget-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    iget-object v1, p0, Lchat/ola/vn/view/j;->n:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/media/MediaRecorder;->setOutputFile(Ljava/lang/String;)V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->prepare()V

    iget-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->start()V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/view/j;->l:J

    iget-object v0, p0, Lchat/ola/vn/view/j;->j:Landroid/os/Handler;

    iget-object v1, p0, Lchat/ola/vn/view/j;->m:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-direct {p0}, Lchat/ola/vn/view/j;->i()V

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    iget-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->reset()V

    iget-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    return-void
.end method

.method private i()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/j;->c:Landroid/widget/TextView;

    const v1, 0x7f0f03a0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    return-void
.end method


# virtual methods
.method public b()V
    .locals 3

    invoke-virtual {p0}, Lchat/ola/vn/view/j;->f()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/view/j;->f:Landroid/widget/TextView;

    const-string v0, "0:00"

    iput-object v0, p0, Lchat/ola/vn/view/j;->k:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/view/j;->c:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/view/j;->k:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/view/j;->d:Landroid/widget/TextView;

    const v1, 0x7f0f05d6

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    const/16 v1, 0x8

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/j;->h:Landroid/view/animation/Animation;

    invoke-virtual {v0}, Landroid/view/animation/Animation;->cancel()V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/view/j;->h:Landroid/view/animation/Animation;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_0
    return-void
.end method

.method public c()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/j;->c:Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/view/j;->f:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/view/j;->d:Landroid/widget/TextView;

    const v1, 0x7f0f05d6

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/j;->i:Landroid/view/animation/Animation;

    invoke-virtual {v0}, Landroid/view/animation/Animation;->cancel()V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/view/j;->i:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_0
    return-void
.end method

.method public d()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/view/j;->d:Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/view/j;->f:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/view/j;->c:Landroid/widget/TextView;

    const v1, 0x7f0f03a1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    const/16 v1, 0x8

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/j;->h:Landroid/view/animation/Animation;

    invoke-virtual {v0}, Landroid/view/animation/Animation;->cancel()V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/view/j;->h:Landroid/view/animation/Animation;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_0
    return-void
.end method

.method public e()V
    .locals 3

    invoke-virtual {p0}, Lchat/ola/vn/view/j;->g()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/view/j;->f:Landroid/widget/TextView;

    const-string v0, "0:00"

    iput-object v0, p0, Lchat/ola/vn/view/j;->k:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/view/j;->c:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/view/j;->k:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/view/j;->d:Landroid/widget/TextView;

    const v1, 0x7f0f05d6

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    const/16 v1, 0x8

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/j;->h:Landroid/view/animation/Animation;

    invoke-virtual {v0}, Landroid/view/animation/Animation;->cancel()V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    iget-object v2, p0, Lchat/ola/vn/view/j;->h:Landroid/view/animation/Animation;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_0
    return-void
.end method

.method public f()V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/view/j;->j:Landroid/os/Handler;

    iget-object v1, p0, Lchat/ola/vn/view/j;->m:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->stop()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-wide v0, p0, Lchat/ola/vn/view/j;->l:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-lez v4, :cond_1

    :try_start_1
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/view/j;->l:J

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/16 v0, 0x3e8

    cmp-long v2, v4, v0

    if-gtz v2, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/view/j;->g:Lchat/ola/vn/view/j$a;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/view/j;->g:Lchat/ola/vn/view/j$a;

    iget-object v1, p0, Lchat/ola/vn/view/j;->n:Ljava/io/File;

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lchat/ola/vn/view/j$a;->l(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_1
    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/view/j;->n:Ljava/io/File;

    return-void
.end method

.method public g()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/view/j;->j:Landroid/os/Handler;

    iget-object v1, p0, Lchat/ola/vn/view/j;->m:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    const-wide/16 v0, 0x0

    :try_start_0
    iput-wide v0, p0, Lchat/ola/vn/view/j;->l:J

    iget-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->stop()V

    iget-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->reset()V

    iget-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;

    invoke-virtual {v0}, Landroid/media/MediaRecorder;->release()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/view/j;->a:Landroid/media/MediaRecorder;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public getOnVoiceRecordListener()Lchat/ola/vn/view/j$a;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/j;->g:Lchat/ola/vn/view/j$a;

    return-object v0
.end method

.method public n_()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/view/j;->h()V

    const-string v0, "0:00"

    iput-object v0, p0, Lchat/ola/vn/view/j;->k:Ljava/lang/String;

    iget-object v0, p0, Lchat/ola/vn/view/j;->c:Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/view/j;->f:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/view/j;->c:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/view/j;->k:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/view/j;->d:Landroid/widget/TextView;

    const v1, 0x7f0f05d6

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    invoke-virtual {v0}, Landroid/widget/TextView;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/view/j;->i:Landroid/view/animation/Animation;

    invoke-virtual {v0}, Landroid/view/animation/Animation;->cancel()V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/view/j;->i:Landroid/view/animation/Animation;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->startAnimation(Landroid/view/animation/Animation;)V

    iget-object v0, p0, Lchat/ola/vn/view/j;->e:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const v0, 0x7f090207

    if-eq p1, v0, :cond_0

    const v0, 0x7f0904b0

    :catch_0
    :cond_0
    return-void
.end method

.method public setOnVoiceRecordListener(Lchat/ola/vn/view/j$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/j;->g:Lchat/ola/vn/view/j$a;

    return-void
.end method
