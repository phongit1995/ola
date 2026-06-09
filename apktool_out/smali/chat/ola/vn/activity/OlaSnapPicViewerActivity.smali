.class public Lchat/ola/vn/activity/OlaSnapPicViewerActivity;
.super Lchat/ola/vn/c;


# static fields
.field static e:Lchat/ola/vn/message/t;


# instance fields
.field protected f:Lchat/ola/vn/view/OlaCachedImageView;

.field protected g:Landroid/widget/ProgressBar;

.field private h:Ljava/util/Timer;

.field private i:J


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Lchat/ola/vn/c;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->i:J

    return-void
.end method

.method private B()V
    .locals 8

    sget-object v0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->e:Lchat/ola/vn/message/t;

    invoke-virtual {v0}, Lchat/ola/vn/message/t;->d()B

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->g:Landroid/widget/ProgressBar;

    invoke-virtual {v0}, Landroid/widget/ProgressBar;->getVisibility()I

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->g:Landroid/widget/ProgressBar;

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    :cond_0
    new-instance v0, Ljava/util/Timer;

    invoke-direct {v0}, Ljava/util/Timer;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->h:Ljava/util/Timer;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->g:Landroid/widget/ProgressBar;

    sget-object v2, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->e:Lchat/ola/vn/message/t;

    invoke-virtual {v2}, Lchat/ola/vn/message/t;->D()S

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/ProgressBar;->setMax(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->g:Landroid/widget/ProgressBar;

    sget-object v2, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->e:Lchat/ola/vn/message/t;

    invoke-virtual {v2}, Lchat/ola/vn/message/t;->C()S

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/ProgressBar;->setProgress(I)V

    iget-object v0, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->g:Landroid/widget/ProgressBar;

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->i:J

    iget-object v2, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->h:Ljava/util/Timer;

    new-instance v3, Lchat/ola/vn/activity/OlaSnapPicViewerActivity$2;

    invoke-direct {v3, p0}, Lchat/ola/vn/activity/OlaSnapPicViewerActivity$2;-><init>(Lchat/ola/vn/activity/OlaSnapPicViewerActivity;)V

    const-wide/16 v4, 0x0

    const-wide/16 v6, 0x1f4

    invoke-virtual/range {v2 .. v7}, Ljava/util/Timer;->scheduleAtFixedRate(Ljava/util/TimerTask;JJ)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->g:Landroid/widget/ProgressBar;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaSnapPicViewerActivity;J)J
    .locals 0

    iput-wide p1, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->i:J

    return-wide p1
.end method

.method public static a(Landroid/content/Context;Lchat/ola/vn/message/t;)V
    .locals 1

    sput-object p1, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->e:Lchat/ola/vn/message/t;

    new-instance p1, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;

    invoke-direct {p1, p0, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 v0, 0x20000

    invoke-virtual {p1, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    invoke-virtual {p0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    :try_start_0
    check-cast p0, Landroid/app/Activity;

    const p1, 0x7f010021

    const v0, 0x7f010024

    invoke-virtual {p0, p1, v0}, Landroid/app/Activity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic a(Lchat/ola/vn/activity/OlaSnapPicViewerActivity;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->B()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/activity/OlaSnapPicViewerActivity;)J
    .locals 2

    iget-wide v0, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->i:J

    return-wide v0
.end method


# virtual methods
.method protected a()V
    .locals 1

    new-instance v0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/activity/OlaSnapPicViewerActivity$1;-><init>(Lchat/ola/vn/activity/OlaSnapPicViewerActivity;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public finish()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->h:Ljava/util/Timer;

    invoke-virtual {v0}, Ljava/util/Timer;->cancel()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->h:Ljava/util/Timer;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-super {p0}, Lchat/ola/vn/c;->finish()V

    const v0, 0x7f010021

    const v1, 0x7f010024

    :try_start_1
    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->overridePendingTransition(II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 0

    invoke-super {p0, p1}, Lchat/ola/vn/c;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f0b01b4

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->setContentView(I)V

    const p1, 0x7f0903ab

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->f:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f0904cc

    invoke-virtual {p0, p1}, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ProgressBar;

    iput-object p1, p0, Lchat/ola/vn/activity/OlaSnapPicViewerActivity;->g:Landroid/widget/ProgressBar;

    return-void
.end method
