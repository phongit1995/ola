.class public Lchat/ola/vn/balloon/OlaBalloonService;
.super Landroid/app/Service;


# instance fields
.field public a:Lchat/ola/vn/balloon/d;

.field b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/balloon/e;",
            ">;"
        }
    .end annotation
.end field

.field c:Landroid/os/Handler;

.field d:Ljava/lang/Runnable;

.field private e:Landroid/view/WindowManager;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/balloon/OlaBalloonService;Lchat/ola/vn/balloon/e;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/balloon/OlaBalloonService;->b(Lchat/ola/vn/balloon/e;)V

    return-void
.end method

.method private b(Lchat/ola/vn/balloon/e;)V
    .locals 2

    :try_start_0
    iget v0, p1, Lchat/ola/vn/balloon/e;->n:I

    if-ltz v0, :cond_0

    iget v0, p1, Lchat/ola/vn/balloon/e;->o:I

    if-ltz v0, :cond_0

    iget-object v0, p1, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v1, p1, Lchat/ola/vn/balloon/e;->n:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v0, p1, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v1, p1, Lchat/ola/vn/balloon/e;->o:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    const/4 v0, -0x1

    iput v0, p1, Lchat/ola/vn/balloon/e;->n:I

    iput v0, p1, Lchat/ola/vn/balloon/e;->o:I

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->e:Landroid/view/WindowManager;

    iget-object v1, p1, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, p1, v1}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    new-instance v0, Lchat/ola/vn/balloon/OlaBalloonService$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/balloon/OlaBalloonService$2;-><init>(Lchat/ola/vn/balloon/OlaBalloonService;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method a(I)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/balloon/e;

    invoke-virtual {p0, p1}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/balloon/e;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Landroid/view/View;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->e:Landroid/view/WindowManager;

    invoke-interface {v0, p1}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->e:Landroid/view/WindowManager;

    invoke-interface {v0, p1, p2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/balloon/a;Landroid/view/WindowManager$LayoutParams;II)V
    .locals 7

    const-wide/16 v5, 0x3e8

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    move v4, p4

    invoke-virtual/range {v0 .. v6}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/balloon/a;Landroid/view/WindowManager$LayoutParams;IIJ)V

    return-void
.end method

.method public a(Lchat/ola/vn/balloon/a;Landroid/view/WindowManager$LayoutParams;IIJ)V
    .locals 2

    new-instance v0, Lchat/ola/vn/balloon/a/b;

    invoke-interface {p1}, Lchat/ola/vn/balloon/a;->getBalloonHandler()Landroid/os/Handler;

    move-result-object v1

    invoke-direct {v0, p1, v1}, Lchat/ola/vn/balloon/a/b;-><init>(Lchat/ola/vn/balloon/a;Landroid/os/Handler;)V

    iget p1, p2, Landroid/view/WindowManager$LayoutParams;->x:I

    iget p2, p2, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {v0, p1, p3, p2, p4}, Lchat/ola/vn/balloon/a/b;->a(IIII)V

    invoke-virtual {v0, p5, p6}, Lchat/ola/vn/balloon/a/b;->a(J)V

    invoke-virtual {v0}, Lchat/ola/vn/balloon/a/b;->a()V

    return-void
.end method

.method a(Lchat/ola/vn/balloon/e;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :catch_0
    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/balloon/e;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v1, v1, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    iget-object v2, p1, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    invoke-virtual {v1, v2}, Lchat/ola/vn/message/f;->equals(Ljava/lang/Object;)Z

    move-result v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    if-eqz v1, :cond_0

    :catch_1
    :cond_1
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->e:Landroid/view/WindowManager;

    invoke-interface {v0, p1}, Landroid/view/WindowManager;->removeViewImmediate(Landroid/view/View;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    return-void
.end method

.method public a(Lchat/ola/vn/message/f;)V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x1

    invoke-virtual {p0, p1, v0, v1}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;Z)V

    return-void
.end method

.method public a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;Z)V
    .locals 8

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x4

    if-eq v0, v1, :cond_d

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v2, 0x1

    if-ne v0, v2, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    :cond_1
    new-instance v0, Ljava/util/Random;

    invoke-direct {v0}, Ljava/util/Random;-><init>()V

    const/16 v3, 0x3c

    invoke-virtual {v0, v3}, Ljava/util/Random;->nextInt(I)I

    move-result v0

    add-int/lit8 v0, v0, -0x1e

    iget-object v3, p0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    const/4 v5, 0x0

    if-eqz v4, :cond_3

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/balloon/e;

    invoke-virtual {v4}, Lchat/ola/vn/balloon/e;->getContact()Lchat/ola/vn/message/f;

    move-result-object v6

    invoke-virtual {p1, v6}, Lchat/ola/vn/message/f;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    goto :goto_0

    :cond_3
    move-object v4, v5

    :goto_0
    const/4 v3, 0x0

    if-nez v4, :cond_8

    if-eqz p3, :cond_7

    new-instance p3, Lchat/ola/vn/balloon/e;

    invoke-direct {p3, p0}, Lchat/ola/vn/balloon/e;-><init>(Lchat/ola/vn/balloon/OlaBalloonService;)V

    iget-object v4, p0, Lchat/ola/vn/balloon/OlaBalloonService;->a:Lchat/ola/vn/balloon/d;

    invoke-virtual {p3, v4}, Lchat/ola/vn/balloon/e;->setBalloonTerminator(Lchat/ola/vn/balloon/d;)V

    iget-object v4, p3, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p3}, Lchat/ola/vn/balloon/e;->getWindowWidth()I

    move-result v6

    invoke-virtual {p3}, Lchat/ola/vn/balloon/e;->getBalloonWidth()I

    move-result v7

    sub-int/2addr v6, v7

    iput v6, v4, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v4, p3, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p3}, Lchat/ola/vn/balloon/e;->getWindowHeight()I

    move-result v6

    div-int/lit8 v6, v6, 0x3

    invoke-virtual {p3}, Lchat/ola/vn/balloon/e;->getBalloonHeight()I

    move-result v7

    div-int/lit8 v7, v7, 0x2

    add-int/2addr v7, v0

    sub-int/2addr v6, v7

    iput v6, v4, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v0, p3, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {p3, v0}, Lchat/ola/vn/balloon/e;->setBackupX(I)V

    iget-object v0, p3, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {p3, v0}, Lchat/ola/vn/balloon/e;->setBackupY(I)V

    invoke-virtual {p3, v3}, Lchat/ola/vn/balloon/e;->setVisibility(I)V

    invoke-virtual {p1, v5}, Lchat/ola/vn/message/f;->a(Ljava/lang/Long;)V

    invoke-virtual {p3, p1}, Lchat/ola/vn/balloon/e;->setContact(Lchat/ola/vn/message/f;)V

    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lt v0, v1, :cond_4

    invoke-virtual {p0, v3}, Lchat/ola/vn/balloon/OlaBalloonService;->a(I)V

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    invoke-interface {v0, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-static {}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->E()Z

    move-result v0

    if-eqz v0, :cond_5

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->G()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void

    :cond_5
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->e:Landroid/view/WindowManager;

    iget-object v1, p3, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, p3, v1}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    if-eqz p2, :cond_6

    invoke-virtual {p3, p2, v2}, Lchat/ola/vn/balloon/e;->a(Lchat/ola/vn/message/d;Z)V

    :cond_6
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->z()I

    move-result p1

    invoke-virtual {p3, p1}, Lchat/ola/vn/balloon/e;->setNotify(I)V

    :cond_7
    return-void

    :cond_8
    invoke-static {}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->E()Z

    move-result v0

    if-eqz v0, :cond_9

    return-void

    :cond_9
    invoke-virtual {v4}, Lchat/ola/vn/balloon/e;->getVisibility()I

    move-result v0

    if-eqz v0, :cond_b

    if-eqz p3, :cond_a

    :try_start_2
    invoke-virtual {v4, v3}, Lchat/ola/vn/balloon/e;->setVisibility(I)V

    invoke-virtual {p1, v5}, Lchat/ola/vn/message/f;->a(Ljava/lang/Long;)V

    iget-object p1, v4, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {v4, p1}, Lchat/ola/vn/balloon/e;->setBackupX(I)V

    iget-object p1, v4, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {v4, p1}, Lchat/ola/vn/balloon/e;->setBackupY(I)V

    iget-object p1, v4, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iput v3, p1, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {v4}, Lchat/ola/vn/balloon/e;->bringToFront()V

    iget-object p1, v4, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-virtual {p0, v4, p1}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V

    if-eqz p2, :cond_a

    invoke-virtual {v4, p2, v2}, Lchat/ola/vn/balloon/e;->a(Lchat/ola/vn/message/d;Z)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :cond_a
    return-void

    :cond_b
    iget-byte p1, v4, Lchat/ola/vn/balloon/e;->a:B

    if-nez p1, :cond_c

    :try_start_3
    invoke-virtual {v4}, Lchat/ola/vn/balloon/e;->bringToFront()V

    iget-object p1, v4, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->x:I

    invoke-virtual {v4, p1}, Lchat/ola/vn/balloon/e;->setBackupX(I)V

    iget-object p1, v4, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget p1, p1, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {v4, p1}, Lchat/ola/vn/balloon/e;->setBackupY(I)V

    iput-byte v2, v4, Lchat/ola/vn/balloon/e;->a:B

    new-instance p1, Lchat/ola/vn/balloon/a/b;

    invoke-virtual {v4}, Lchat/ola/vn/balloon/e;->getBalloonHandler()Landroid/os/Handler;

    move-result-object p3

    invoke-direct {p1, v4, p3}, Lchat/ola/vn/balloon/a/b;-><init>(Lchat/ola/vn/balloon/a;Landroid/os/Handler;)V

    iget-object p3, v4, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget p3, p3, Landroid/view/WindowManager$LayoutParams;->x:I

    iget-object v0, v4, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v0, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    iget-object v1, v4, Lchat/ola/vn/balloon/e;->b:Landroid/view/WindowManager$LayoutParams;

    iget v1, v1, Landroid/view/WindowManager$LayoutParams;->y:I

    invoke-virtual {p1, p3, v3, v0, v1}, Lchat/ola/vn/balloon/a/b;->a(IIII)V

    const-wide/16 v0, 0x12c

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/balloon/a/b;->a(J)V

    invoke-virtual {p1}, Lchat/ola/vn/balloon/a/b;->a()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    :cond_c
    if-eqz p2, :cond_d

    if-eqz v4, :cond_d

    invoke-virtual {v4, p2, v2}, Lchat/ola/vn/balloon/e;->a(Lchat/ola/vn/message/d;Z)V

    :cond_d
    return-void
.end method

.method public a(Lchat/ola/vn/message/f;Z)V
    .locals 1

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0, p2}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;Z)V

    return-void
.end method

.method public a(Ljava/lang/String;SI)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/balloon/e;

    iget-object v2, v1, Lchat/ola/vn/balloon/e;->s:Lchat/ola/vn/message/f;

    invoke-virtual {v2, p1, p2}, Lchat/ola/vn/message/f;->a(Ljava/lang/String;S)Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-virtual {v1, p3}, Lchat/ola/vn/balloon/e;->setNotify(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public b()V
    .locals 1

    new-instance v0, Lchat/ola/vn/balloon/OlaBalloonService$3;

    invoke-direct {v0, p0}, Lchat/ola/vn/balloon/OlaBalloonService$3;-><init>(Lchat/ola/vn/balloon/OlaBalloonService;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public b(Landroid/view/View;)V
    .locals 1

    :try_start_0
    instance-of v0, p1, Lchat/ola/vn/balloon/e;

    if-eqz v0, :cond_0

    check-cast p1, Lchat/ola/vn/balloon/e;

    invoke-virtual {p0, p1}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/balloon/e;)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->e:Landroid/view/WindowManager;

    invoke-interface {v0, p1}, Landroid/view/WindowManager;->removeView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method b(Landroid/view/View;Landroid/view/WindowManager$LayoutParams;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->e:Landroid/view/WindowManager;

    invoke-interface {v0, p1, p2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b(Lchat/ola/vn/message/f;)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    if-eqz v0, :cond_1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/balloon/e;

    invoke-virtual {v1}, Lchat/ola/vn/balloon/e;->getContact()Lchat/ola/vn/message/f;

    move-result-object v2

    invoke-virtual {p1, v2}, Lchat/ola/vn/message/f;->equals(Ljava/lang/Object;)Z

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz v2, :cond_0

    :try_start_1
    invoke-interface {v0}, Ljava/util/Iterator;->remove()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/balloon/OlaBalloonService;->e:Landroid/view/WindowManager;

    invoke-interface {p1, v1}, Landroid/view/WindowManager;->removeViewImmediate(Landroid/view/View;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_1
    return-void
.end method

.method public c()V
    .locals 1

    :try_start_0
    new-instance v0, Lchat/ola/vn/balloon/OlaBalloonService$4;

    invoke-direct {v0, p0}, Lchat/ola/vn/balloon/OlaBalloonService$4;-><init>(Lchat/ola/vn/balloon/OlaBalloonService;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c(Lchat/ola/vn/message/f;)V
    .locals 2

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;

    new-instance v1, Lchat/ola/vn/e/e;

    invoke-direct {v1}, Lchat/ola/vn/e/e;-><init>()V

    invoke-static {v0, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    invoke-static {}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->E()Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p1

    invoke-static {p0, v0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Landroid/content/Context;Ljava/lang/String;S)V

    return-void

    :cond_1
    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;

    invoke-virtual {v0, p1}, Lchat/ola/vn/activity/OlaBalloonChatViewActivity;->a(Lchat/ola/vn/message/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public d()I
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xd
    .end annotation

    :try_start_0
    const-string v0, "window"

    invoke-virtual {p0, v0}, Lchat/ola/vn/balloon/OlaBalloonService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-static {}, Lcom/mg/ola/common/d/g;->e()Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Landroid/graphics/Point;

    invoke-direct {v1}, Landroid/graphics/Point;-><init>()V

    invoke-virtual {v0, v1}, Landroid/view/Display;->getSize(Landroid/graphics/Point;)V

    iget v0, v1, Landroid/graphics/Point;->x:I

    return v0

    :cond_0
    invoke-virtual {v0}, Landroid/view/Display;->getWidth()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    sget v0, Lchat/ola/vn/e;->c:I

    return v0
.end method

.method public e()I
    .locals 2
    .annotation build Landroid/annotation/TargetApi;
        value = 0xd
    .end annotation

    :try_start_0
    const-string v0, "window"

    invoke-virtual {p0, v0}, Lchat/ola/vn/balloon/OlaBalloonService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    invoke-static {}, Lcom/mg/ola/common/d/g;->e()Z

    move-result v1

    if-eqz v1, :cond_0

    new-instance v1, Landroid/graphics/Point;

    invoke-direct {v1}, Landroid/graphics/Point;-><init>()V

    invoke-virtual {v0, v1}, Landroid/view/Display;->getSize(Landroid/graphics/Point;)V

    iget v0, v1, Landroid/graphics/Point;->y:I

    return v0

    :cond_0
    invoke-virtual {v0}, Landroid/view/Display;->getHeight()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    sget v0, Lchat/ola/vn/e;->d:I

    return v0
.end method

.method public f()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lchat/ola/vn/balloon/e;",
            ">;"
        }
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->b:Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()V
    .locals 3

    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    const-string v0, "window"

    invoke-virtual {p0, v0}, Lchat/ola/vn/balloon/OlaBalloonService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    iput-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->e:Landroid/view/WindowManager;

    sput-object p0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->a:Lchat/ola/vn/balloon/d;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/balloon/d;

    invoke-direct {v0, p0}, Lchat/ola/vn/balloon/d;-><init>(Lchat/ola/vn/balloon/OlaBalloonService;)V

    iput-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->a:Lchat/ola/vn/balloon/d;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->a:Lchat/ola/vn/balloon/d;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Lchat/ola/vn/balloon/d;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->e:Landroid/view/WindowManager;

    iget-object v1, p0, Lchat/ola/vn/balloon/OlaBalloonService;->a:Lchat/ola/vn/balloon/d;

    iget-object v2, p0, Lchat/ola/vn/balloon/OlaBalloonService;->a:Lchat/ola/vn/balloon/d;

    iget-object v2, v2, Lchat/ola/vn/balloon/d;->b:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->d:Ljava/lang/Runnable;

    if-nez v0, :cond_1

    new-instance v0, Lchat/ola/vn/balloon/OlaBalloonService$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/balloon/OlaBalloonService$1;-><init>(Lchat/ola/vn/balloon/OlaBalloonService;)V

    iput-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->d:Ljava/lang/Runnable;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->c:Landroid/os/Handler;

    if-nez v0, :cond_2

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->c:Landroid/os/Handler;

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/balloon/OlaBalloonService;->c:Landroid/os/Handler;

    iget-object v1, p0, Lchat/ola/vn/balloon/OlaBalloonService;->d:Ljava/lang/Runnable;

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public onDestroy()V
    .locals 1

    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    invoke-virtual {p0}, Lchat/ola/vn/balloon/OlaBalloonService;->b()V

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    return-void
.end method
