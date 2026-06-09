.class public abstract Lchat/ola/vn/c;
.super Landroid/support/v4/app/FragmentActivity;

# interfaces
.implements Lchat/ola/vn/network/f;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale",
        "NewApi",
        "RtlHardcoded"
    }
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/c$a;
    }
.end annotation


# static fields
.field protected static b_:Lchat/ola/vn/c; = null

.field public static c_:Z = true

.field public static d_:Ljava/lang/Long; = null

.field private static f:J = 0x0L

.field private static g:Ljava/lang/String; = null

.field private static h:I = 0x0

.field private static i:Z = false

.field private static j:Z = false


# instance fields
.field a_:Landroid/app/Dialog;

.field private e:Lchat/ola/vn/i/b;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Landroid/support/v4/app/FragmentActivity;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/c;->e:Lchat/ola/vn/i/b;

    return-void
.end method

.method static synthetic A()Ljava/lang/String;
    .locals 1

    sget-object v0, Lchat/ola/vn/c;->g:Ljava/lang/String;

    return-object v0
.end method

.method private B()V
    .locals 2

    invoke-virtual {p0}, Lchat/ola/vn/c;->isTaskRoot()Z

    move-result v0

    if-eqz v0, :cond_2

    instance-of v0, p0, Lchat/ola/vn/activity/OlaChatViewActivity;

    if-eqz v0, :cond_0

    invoke-static {p0}, Lchat/ola/vn/m/e;->b(Landroid/content/Context;)V

    :goto_0
    invoke-virtual {p0}, Lchat/ola/vn/c;->finish()V

    return-void

    :cond_0
    instance-of v0, p0, Lchat/ola/vn/me/OlaMeCommentActivity;

    const/4 v1, 0x1

    if-eqz v0, :cond_1

    :goto_1
    invoke-static {p0, v1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->a(Landroid/content/Context;I)V

    goto :goto_0

    :cond_1
    instance-of v0, p0, Lchat/ola/vn/me/OlaUserMePageActivity;

    if-eqz v0, :cond_2

    goto :goto_1

    :cond_2
    invoke-super {p0}, Landroid/support/v4/app/FragmentActivity;->onBackPressed()V

    return-void
.end method

.method private C()V
    .locals 6

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sget-wide v2, Lchat/ola/vn/c;->f:J

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/32 v0, 0xea60

    cmp-long v2, v4, v0

    if-ltz v2, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lchat/ola/vn/c;->f:J

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->w()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method private D()V
    .locals 6

    :try_start_0
    sget-object v0, Lchat/ola/vn/c;->d_:Ljava/lang/Long;

    if-eqz v0, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sget-object v2, Lchat/ola/vn/c;->d_:Ljava/lang/Long;

    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    const/4 v4, 0x0

    sub-long v4, v0, v2

    sget-wide v0, Lchat/ola/vn/lock/OlaLockScreenActivity;->r:J

    cmp-long v2, v4, v0

    if-lez v2, :cond_0

    const/4 v0, 0x1

    sput-boolean v0, Lchat/ola/vn/c;->c_:Z

    :cond_0
    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/c;->d_:Ljava/lang/Long;

    :cond_1
    sget-boolean v0, Lchat/ola/vn/c;->c_:Z

    if-eqz v0, :cond_2

    invoke-static {p0}, Lchat/ola/vn/lock/OlaLockScreenActivity;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method private E()Z
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->d()V

    goto :goto_0

    :cond_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/network/OlaNetworkService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lchat/ola/vn/c;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    :goto_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    if-nez v0, :cond_1

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lchat/ola/vn/c;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/c;->b()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-static {}, Lchat/ola/vn/h;->g()Z

    move-result v0

    if-nez v0, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/c;->h()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v0, 0x0

    return v0

    :catch_0
    :cond_2
    const/4 v0, 0x1

    return v0
.end method

.method static synthetic a(Lchat/ola/vn/c;Lchat/ola/vn/i/b;)Lchat/ola/vn/i/b;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/c;->e:Lchat/ola/vn/i/b;

    return-object p1
.end method

.method public static c()Lchat/ola/vn/c;
    .locals 1

    sget-object v0, Lchat/ola/vn/c;->b_:Lchat/ola/vn/c;

    return-object v0
.end method

.method static synthetic e(Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    sput-object p0, Lchat/ola/vn/c;->g:Ljava/lang/String;

    return-object p0
.end method

.method public static x()Z
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/c;->g:Ljava/lang/String;

    const-string v1, "vn"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v0

    :catch_0
    const/4 v0, 0x0

    return v0
.end method

.method public static y()Ljava/lang/String;
    .locals 1

    sget-object v0, Lchat/ola/vn/c;->g:Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method protected abstract a()V
.end method

.method public a(I)V
    .locals 4

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    const v1, 0x7f0f00f1

    invoke-virtual {v0, v1}, Lchat/ola/vn/r/a/c;->b(I)Lchat/ola/vn/entry/e;

    move-result-object v0

    const/4 v2, 0x2

    if-nez v0, :cond_0

    const v0, 0x7f080799

    invoke-static {v1, v0, v1}, Lchat/ola/vn/entry/e;->a(III)Lchat/ola/vn/entry/e;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/r/a/c;->a(Lchat/ola/vn/entry/e;I)V

    :cond_0
    if-eqz p1, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, ""

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/entry/e;->c(Ljava/lang/String;)V

    invoke-virtual {v0, v2}, Lchat/ola/vn/entry/e;->b(I)V

    goto :goto_0

    :cond_1
    const/4 p1, 0x1

    invoke-virtual {v0, p1}, Lchat/ola/vn/entry/e;->b(I)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Lchat/ola/vn/entry/e;->c(Ljava/lang/String;)V

    :goto_0
    sget-object p1, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/c;->g()V

    sget-object p1, Lchat/ola/vn/c;->b_:Lchat/ola/vn/c;

    check-cast p1, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->I()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(IILandroid/widget/FrameLayout;)V
    .locals 9

    const v4, 0x7f080860

    const-wide/16 v5, 0x3e8

    const-wide/16 v7, 0x7d0

    move-object v0, p0

    move v1, p1

    move v2, p2

    move-object v3, p3

    :try_start_0
    invoke-virtual/range {v0 .. v8}, Lchat/ola/vn/c;->a(IILandroid/widget/FrameLayout;IJJ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(IILandroid/widget/FrameLayout;IJJ)V
    .locals 4

    :try_start_0
    sget v0, Lchat/ola/vn/c;->h:I

    if-nez v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/c;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x7f070143

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v0

    float-to-int v0, v0

    sput v0, Lchat/ola/vn/c;->h:I

    :cond_0
    new-instance v0, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v1, -0x2

    sget v2, Lchat/ola/vn/c;->h:I

    const/16 v3, 0x33

    invoke-direct {v0, v1, v2, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    sget v1, Lchat/ola/vn/c;->h:I

    div-int/lit8 v1, v1, 0x2

    sub-int/2addr p1, v1

    sget v1, Lchat/ola/vn/c;->h:I

    div-int/lit8 v1, v1, 0x2

    sub-int/2addr p2, v1

    const/4 v1, 0x0

    invoke-virtual {v0, p1, p2, v1, v1}, Landroid/widget/FrameLayout$LayoutParams;->setMargins(IIII)V

    new-instance p1, Landroid/widget/ImageView;

    invoke-direct {p1, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    invoke-virtual {p1, v1}, Landroid/widget/ImageView;->setClickable(Z)V

    const/4 p2, 0x1

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->setAdjustViewBounds(Z)V

    invoke-virtual {p1, p4}, Landroid/widget/ImageView;->setImageResource(I)V

    invoke-virtual {p3, p1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    const p2, 0x7f010030

    invoke-static {p0, p2}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object p2

    const-wide/16 v0, 0x0

    cmp-long p4, p7, v0

    if-lez p4, :cond_1

    new-instance p4, Ljava/util/Random;

    invoke-direct {p4}, Ljava/util/Random;-><init>()V

    invoke-virtual {p4}, Ljava/util/Random;->nextLong()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Math;->abs(J)J

    move-result-wide v0

    rem-long/2addr v0, p7

    const/4 p4, 0x0

    add-long p7, p5, v0

    move-wide p5, p7

    :cond_1
    invoke-virtual {p2, p5, p6}, Landroid/view/animation/Animation;->setDuration(J)V

    new-instance p4, Lchat/ola/vn/c$7;

    invoke-direct {p4, p0, p1, p3}, Lchat/ola/vn/c$7;-><init>(Lchat/ola/vn/c;Landroid/widget/ImageView;Landroid/widget/FrameLayout;)V

    invoke-virtual {p2, p4}, Landroid/view/animation/Animation;->setAnimationListener(Landroid/view/animation/Animation$AnimationListener;)V

    invoke-virtual {p1, p2}, Landroid/widget/ImageView;->startAnimation(Landroid/view/animation/Animation;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public a(ILandroid/widget/FrameLayout;)V
    .locals 7

    const/16 v0, 0xe

    if-le p1, v0, :cond_0

    const/16 p1, 0xe

    :cond_0
    const/4 v0, 0x0

    :goto_0
    if-ge v0, p1, :cond_2

    :try_start_0
    new-instance v1, Ljava/util/Random;

    invoke-direct {v1}, Ljava/util/Random;-><init>()V

    sget v2, Lchat/ola/vn/e;->c:I

    div-int/lit8 v2, v2, 0x5

    invoke-virtual {v1, v2}, Ljava/util/Random;->nextInt(I)I

    move-result v1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    const-wide/16 v4, 0x2

    rem-long/2addr v2, v4

    const-wide/16 v4, 0x0

    cmp-long v6, v2, v4

    if-nez v6, :cond_1

    neg-int v1, v1

    :cond_1
    new-instance v2, Ljava/util/Random;

    invoke-direct {v2}, Ljava/util/Random;-><init>()V

    sget v3, Lchat/ola/vn/e;->d:I

    div-int/lit8 v3, v3, 0x4

    invoke-virtual {v2, v3}, Ljava/util/Random;->nextInt(I)I

    move-result v2

    neg-int v2, v2

    sget v3, Lchat/ola/vn/e;->c:I

    div-int/lit8 v3, v3, 0x2

    add-int/2addr v3, v1

    sget v1, Lchat/ola/vn/e;->d:I

    div-int/lit8 v1, v1, 0x2

    add-int/2addr v1, v2

    invoke-virtual {p0, v3, v1, p2}, Lchat/ola/vn/c;->a(IILandroid/widget/FrameLayout;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_0
    :cond_2
    return-void
.end method

.method public a(ILjava/lang/String;[B)V
    .locals 0

    invoke-virtual {p0}, Lchat/ola/vn/c;->h()V

    return-void
.end method

.method public a(ILjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    .locals 6

    const/4 p3, 0x1

    const/16 p4, 0x3b

    if-ne p5, p4, :cond_1

    if-eq p1, p3, :cond_0

    goto :goto_0

    :cond_0
    const p1, 0x7f0f01fc

    invoke-static {p0, p1}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V

    return-void

    :cond_1
    :goto_0
    if-eqz p1, :cond_3

    const/16 p3, 0x17

    if-eq p1, p3, :cond_2

    return-void

    :cond_2
    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/c;->b(Z)V

    new-instance p1, Lchat/ola/vn/c$2;

    invoke-direct {p1, p0, p2}, Lchat/ola/vn/c$2;-><init>(Lchat/ola/vn/c;Ljava/lang/String;)V

    const-wide/16 p2, 0x3e8

    :goto_1
    invoke-static {p1, p2, p3}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    return-void

    :cond_3
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_7

    const-string p1, "Th\u00f4ng tin c\u00e1 nh\u00e2n thay \u0111\u1ed5i. B\u1ea1n c\u1ea7n \u0111\u0103ng nh\u1eadp l\u1ea1i."

    invoke-virtual {p2, p1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result p1

    if-ltz p1, :cond_4

    invoke-virtual {p0, p3}, Lchat/ola/vn/c;->b(Z)V

    new-instance p1, Lchat/ola/vn/c$3;

    invoke-direct {p1, p0, p2}, Lchat/ola/vn/c$3;-><init>(Lchat/ola/vn/c;Ljava/lang/String;)V

    const-wide/16 p2, 0x258

    goto :goto_1

    :cond_4
    const-string p1, "verified to join room"

    invoke-virtual {p2, p1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result p1

    if-gez p1, :cond_6

    const-string p1, "x\u00e1c th\u1ef1c nick m\u1edbi \u0111\u01b0\u1ee3c v\u00e0o ph\u00f2ng"

    invoke-virtual {p2, p1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result p1

    if-ltz p1, :cond_5

    goto :goto_2

    :cond_5
    if-nez p5, :cond_7

    invoke-static {p0, p2}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_6
    :goto_2
    const p1, 0x7f0f00a2

    invoke-virtual {p0, p1}, Lchat/ola/vn/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    const p1, 0x7f0f068c

    invoke-virtual {p0, p1}, Lchat/ola/vn/c;->getString(I)Ljava/lang/String;

    move-result-object v3

    const p1, 0x7f0f0480

    invoke-virtual {p0, p1}, Lchat/ola/vn/c;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/c$4;

    invoke-direct {v5, p0}, Lchat/ola/vn/c$4;-><init>(Lchat/ola/vn/c;)V

    move-object v0, p0

    move-object v2, p2

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;

    :cond_7
    return-void
.end method

.method public a(ILjava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public a(JIS)V
    .locals 0

    return-void
.end method

.method public a(JLjava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(JLjava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(J",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;S)V"
        }
    .end annotation

    return-void
.end method

.method public a(JLjava/lang/String;[Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public a(JS)V
    .locals 0

    return-void
.end method

.method public a(Landroid/view/View;Landroid/widget/FrameLayout;)V
    .locals 10

    if-eqz p2, :cond_0

    const/4 v0, 0x2

    :try_start_0
    new-array v0, v0, [I

    invoke-virtual {p1, v0}, Landroid/view/View;->getLocationInWindow([I)V

    const/4 p1, 0x0

    aget v2, v0, p1

    const/4 p1, 0x1

    aget v3, v0, p1

    const v5, 0x7f080860

    const-wide/16 v6, 0x5dc

    const-wide/16 v8, 0x0

    move-object v1, p0

    move-object v4, p2

    invoke-virtual/range {v1 .. v9}, Lchat/ola/vn/c;->a(IILandroid/widget/FrameLayout;IJJ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/ag;S)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/b;S)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/g;Ljava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/entity/g;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;S)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/lang/Class;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)V"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/c;->a(Ljava/lang/Class;Z)V

    return-void
.end method

.method public a(Ljava/lang/Class;Landroid/os/Bundle;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;",
            "Landroid/os/Bundle;",
            ")V"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0, p2}, Lchat/ola/vn/c;->a(Ljava/lang/Class;ZLandroid/os/Bundle;)V

    return-void
.end method

.method public a(Ljava/lang/Class;Z)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;Z)V"
        }
    .end annotation

    const/4 v0, 0x0

    invoke-virtual {p0, p1, p2, v0}, Lchat/ola/vn/c;->a(Ljava/lang/Class;ZLandroid/os/Bundle;)V

    return-void
.end method

.method public a(Ljava/lang/Class;ZLandroid/os/Bundle;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;Z",
            "Landroid/os/Bundle;",
            ")V"
        }
    .end annotation

    :try_start_0
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0, p0, p1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    if-eqz p3, :cond_0

    invoke-virtual {v0, p3}, Landroid/content/Intent;->putExtras(Landroid/os/Bundle;)Landroid/content/Intent;

    :cond_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/c;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0, p0, p1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/high16 p1, 0x10000000

    invoke-virtual {v0, p1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    if-eqz p3, :cond_1

    invoke-virtual {v0, p3}, Landroid/content/Intent;->putExtras(Landroid/os/Bundle;)Landroid/content/Intent;

    :cond_1
    invoke-virtual {p0, v0}, Lchat/ola/vn/c;->startActivity(Landroid/content/Intent;)V

    :goto_0
    if-eqz p2, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/c;->finish()V

    :cond_2
    return-void
.end method

.method public a(Ljava/lang/Short;I)V
    .locals 1

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1, p2}, Lchat/ola/vn/message/g;->a(Ljava/lang/Short;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;I)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;ISLjava/lang/String;JLjava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "IS",
            "Ljava/lang/String;",
            "J",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ah;",
            ">;S)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/lang/String;I[I[I)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;JS)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Lchat/ola/vn/entity/i;Lchat/ola/vn/entity/l;S)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object p1

    invoke-virtual {p1, p2}, Lchat/ola/vn/util/f;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    sget-boolean p1, Lchat/ola/vn/c/x;->x:Z

    if-eqz p1, :cond_0

    const-string p1, " "

    invoke-static {p0, p2, p1}, Lchat/ola/vn/m/m;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_0
    new-instance p1, Landroid/content/Intent;

    const-string v0, "android.intent.action.VIEW"

    invoke-static {p2}, Lchat/ola/vn/util/http/c;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object p2

    invoke-direct {p1, v0, p2}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    invoke-virtual {p0, p1}, Lchat/ola/vn/c;->startActivity(Landroid/content/Intent;)V

    const p1, 0x7f010038

    const p2, 0x7f010039

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/c;->overridePendingTransition(II)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ac;",
            ">;S)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;[Lchat/ola/vn/entity/g;S)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/i;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;S)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;SI)V
    .locals 7

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object v1

    invoke-virtual {v1, p2}, Lchat/ola/vn/j;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object p2

    if-eqz p2, :cond_0

    invoke-virtual {p2}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object v0

    :cond_0
    const p2, 0x7f0f009b

    invoke-virtual {p0, p2}, Lchat/ola/vn/c;->getString(I)Ljava/lang/String;

    move-result-object v2

    const p2, 0x7f0f0323

    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v3, 0x0

    int-to-long v4, p3

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p3

    aput-object p3, v1, v3

    const/4 p3, 0x1

    aput-object v0, v1, p3

    const/4 p3, 0x2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "@"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    aput-object p1, v1, p3

    invoke-virtual {p0, p2, v1}, Lchat/ola/vn/c;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    const p1, 0x7f0f06a7

    invoke-virtual {p0, p1}, Lchat/ola/vn/c;->getString(I)Ljava/lang/String;

    move-result-object v4

    const p1, 0x7f0f0480

    invoke-virtual {p0, p1}, Lchat/ola/vn/c;->getString(I)Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/c$6;

    invoke-direct {v6, p0}, Lchat/ola/vn/c$6;-><init>(Lchat/ola/vn/c;)V

    move-object v1, p0

    invoke-static/range {v1 .. v6}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/e;

    return-void
.end method

.method public a(Ljava/lang/String;SIJS)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;SIS)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;SLjava/lang/String;Ljava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "S",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/d;",
            ">;S)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/lang/String;SLjava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "S",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;S)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/lang/String;SS)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;[B)V
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    array-length v1, p2

    invoke-static {p2, v0, v1}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object p2

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const p1, 0x7f0f05ec

    invoke-virtual {p0, p1}, Lchat/ola/vn/c;->getString(I)Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :cond_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/c;->e:Lchat/ola/vn/i/b;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c;->e:Lchat/ola/vn/i/b;

    invoke-virtual {v0}, Lchat/ola/vn/i/b;->dismiss()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_1
    :try_start_2
    new-instance v0, Lchat/ola/vn/i/b;

    const v1, 0x7f0f05ed

    invoke-virtual {p0, v1}, Lchat/ola/vn/c;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, p0, v1, p1, p2}, Lchat/ola/vn/i/b;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Landroid/graphics/Bitmap;)V

    iput-object v0, p0, Lchat/ola/vn/c;->e:Lchat/ola/vn/i/b;

    iget-object p1, p0, Lchat/ola/vn/c;->e:Lchat/ola/vn/i/b;

    new-instance p2, Lchat/ola/vn/c$5;

    invoke-direct {p2, p0}, Lchat/ola/vn/c$5;-><init>(Lchat/ola/vn/c;)V

    invoke-virtual {p1, p2}, Lchat/ola/vn/i/b;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)V

    iget-object p1, p0, Lchat/ola/vn/c;->e:Lchat/ola/vn/i/b;

    invoke-virtual {p1}, Lchat/ola/vn/i/b;->show()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    return-void
.end method

.method public a(Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public a(Ljava/util/List;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;I)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/util/List;Ljava/lang/String;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/util/List;Ljava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ac;",
            ">;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ah;",
            ">;S)V"
        }
    .end annotation

    return-void
.end method

.method public a(Ljava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/s;",
            ">;S)V"
        }
    .end annotation

    return-void
.end method

.method public a(S)V
    .locals 0

    return-void
.end method

.method public a(SS)V
    .locals 0

    return-void
.end method

.method protected final a(Z)V
    .locals 2

    const/4 v0, 0x1

    :try_start_0
    invoke-virtual {p0, v0}, Lchat/ola/vn/c;->requestWindowFeature(I)Z

    const/16 v1, 0x400

    if-eqz p1, :cond_1

    invoke-static {}, Lcom/mg/ola/common/d/g;->h()Z

    move-result p1

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/c;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object p1

    const/16 v0, 0x1706

    :goto_0
    invoke-virtual {p1, v0}, Landroid/view/View;->setSystemUiVisibility(I)V

    return-void

    :cond_0
    invoke-static {}, Lcom/mg/ola/common/d/g;->g()Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/c;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1, v1, v1}, Landroid/view/Window;->setFlags(II)V

    invoke-virtual {p0}, Lchat/ola/vn/c;->getWindow()Landroid/view/Window;

    move-result-object p1

    :goto_1
    invoke-virtual {p1}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object p1

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/c;->getWindow()Landroid/view/Window;

    move-result-object p1

    invoke-virtual {p1, v1, v1}, Landroid/view/Window;->setFlags(II)V

    invoke-static {}, Lcom/mg/ola/common/d/g;->g()Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/c;->getWindow()Landroid/view/Window;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    :cond_2
    return-void
.end method

.method public a([BS)V
    .locals 0

    return-void
.end method

.method public a([Lchat/ola/vn/entity/j;IS)V
    .locals 0

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/c;->a(I)V

    return-void
.end method

.method public a_(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public b(I)V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/c;->z()Landroid/widget/FrameLayout;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0, p1, v0}, Lchat/ola/vn/c;->a(ILandroid/widget/FrameLayout;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b(JIS)V
    .locals 0

    if-lez p3, :cond_0

    :try_start_0
    sget-object p1, Lchat/ola/vn/c;->b_:Lchat/ola/vn/c;

    check-cast p1, Lchat/ola/vn/activity/OlaBottomTabActivity;

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaBottomTabActivity;->I()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b(JS)V
    .locals 0

    return-void
.end method

.method public b(Landroid/view/View;Landroid/widget/FrameLayout;)V
    .locals 10

    if-eqz p2, :cond_0

    const/4 v0, 0x2

    :try_start_0
    new-array v0, v0, [I

    invoke-virtual {p1, v0}, Landroid/view/View;->getLocationInWindow([I)V

    const/4 p1, 0x0

    aget v2, v0, p1

    const/4 p1, 0x1

    aget v3, v0, p1

    const v5, 0x7f080861

    const-wide/16 v6, 0x5dc

    const-wide/16 v8, 0x0

    move-object v1, p0

    move-object v4, p2

    invoke-virtual/range {v1 .. v9}, Lchat/ola/vn/c;->a(IILandroid/widget/FrameLayout;IJJ)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public b(Ljava/lang/String;I)V
    .locals 0

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/a;",
            ">;S)V"
        }
    .end annotation

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/util/List;Ljava/lang/String;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/l;",
            ">;",
            "Ljava/lang/String;",
            "S)V"
        }
    .end annotation

    return-void
.end method

.method public b(Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public b(Ljava/lang/String;SIS)V
    .locals 2

    :try_start_0
    invoke-static {}, Lchat/ola/vn/j;->a()Lchat/ola/vn/j;

    move-result-object p4

    invoke-virtual {p4, p2}, Lchat/ola/vn/j;->b(I)Lchat/ola/vn/entity/ah;

    move-result-object p4

    if-eqz p4, :cond_0

    invoke-virtual {p4}, Lchat/ola/vn/entity/ah;->d()Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :cond_0
    new-instance p4, Ljava/lang/StringBuilder;

    invoke-direct {p4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p4, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p2, ""

    invoke-virtual {p4, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    :goto_0
    const p4, 0x7f0f027a

    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v1, 0x0

    aput-object p1, v0, v1

    const/4 p1, 0x1

    aput-object p2, v0, p1

    const/4 p1, 0x2

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    aput-object p2, v0, p1

    invoke-virtual {p0, p4, v0}, Lchat/ola/vn/c;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b(Ljava/lang/String;[B)V
    .locals 0

    return-void
.end method

.method public b(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/af;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public b(Ljava/util/List;S)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;S)V"
        }
    .end annotation

    return-void
.end method

.method public b(S)V
    .locals 0

    return-void
.end method

.method public b(SS)V
    .locals 0

    return-void
.end method

.method public b(Z)V
    .locals 3

    :try_start_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lchat/ola/vn/network/OlaNetworkService;->k:Z

    :cond_0
    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {v1}, Lchat/ola/vn/h;->d(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/c/t;->b()V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v2

    invoke-virtual {v2}, Lchat/ola/vn/c/t;->c()V

    sget-object v2, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    invoke-virtual {v2}, Lchat/ola/vn/r/a/f;->o()V

    sget-object v2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v2}, Lchat/ola/vn/r/a/e;->e()V

    sget-object v2, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {v2}, Lchat/ola/vn/r/b;->j()V

    sget-object v2, Lchat/ola/vn/h;->w:Lchat/ola/vn/r/a;

    invoke-interface {v2, v1}, Lchat/ola/vn/r/a;->a(Ljava/util/List;)V

    sget-object v1, Lchat/ola/vn/h;->v:Lchat/ola/vn/r/a/c;

    invoke-virtual {v1}, Lchat/ola/vn/r/a/c;->b()V

    const-wide/16 v1, 0x0

    sput-wide v1, Lchat/ola/vn/transferken/c;->a:J

    if-nez p1, :cond_1

    invoke-static {p0, v0}, Lchat/ola/vn/h/b;->b(Landroid/content/Context;Ljava/lang/String;)V

    :cond_1
    invoke-static {}, Lchat/ola/vn/activity/OlaBottomTabActivity;->E()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-static {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/c;->finish()V

    :cond_2
    return-void
.end method

.method protected b()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public c(Ljava/lang/String;I)V
    .locals 0

    return-void
.end method

.method public c(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public c(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public c(Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public d(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public d(Ljava/lang/String;I)V
    .locals 0

    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public d(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public d(Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method protected d()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public e(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public e(Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method protected e()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public f()I
    .locals 1

    sget v0, Lchat/ola/vn/f;->b:I

    return v0
.end method

.method public f(Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method public finish()V
    .locals 0

    invoke-super {p0}, Landroid/support/v4/app/FragmentActivity;->finish()V

    invoke-virtual {p0}, Lchat/ola/vn/c;->i()V

    return-void
.end method

.method public g()I
    .locals 1

    sget v0, Lchat/ola/vn/f;->c:I

    return v0
.end method

.method public g(Ljava/lang/String;S)V
    .locals 0

    return-void
.end method

.method protected h()V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/activity/OlaLoginActivity;->a(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/c;->finish()V

    :cond_0
    return-void
.end method

.method public i()V
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/c;->getCurrentFocus()Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v1, "input_method"

    invoke-virtual {p0, v1}, Lchat/ola/vn/c;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/inputmethod/InputMethodManager;

    invoke-virtual {v0}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z

    invoke-virtual {v0}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v0

    invoke-virtual {v1, v0, v3}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromInputMethod(Landroid/os/IBinder;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public j()V
    .locals 0

    return-void
.end method

.method public k()V
    .locals 0

    return-void
.end method

.method public l()V
    .locals 0

    invoke-virtual {p0}, Lchat/ola/vn/c;->h()V

    return-void
.end method

.method public m()V
    .locals 0

    return-void
.end method

.method public n()V
    .locals 0

    return-void
.end method

.method public o()V
    .locals 0

    return-void
.end method

.method public onBackPressed()V
    .locals 1

    invoke-static {p0}, Lchat/ola/vn/activity/OlaReleaseAppActivity;->a(Landroid/content/Context;)V

    invoke-virtual {p0}, Lchat/ola/vn/c;->e()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/c;->d()Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/c;->B()V

    :cond_1
    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/support/v4/app/FragmentActivity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 2

    invoke-super {p0, p1}, Landroid/support/v4/app/FragmentActivity;->onCreate(Landroid/os/Bundle;)V

    sput-object p0, Lchat/ola/vn/c;->b_:Lchat/ola/vn/c;

    sget p1, Lchat/ola/vn/h;->i:I

    if-nez p1, :cond_0

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/c;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object p1

    invoke-virtual {p0}, Lchat/ola/vn/c;->getPackageName()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object p1

    iget p1, p1, Landroid/content/pm/PackageInfo;->versionCode:I

    sput p1, Lchat/ola/vn/h;->i:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    sget-boolean p1, Lchat/ola/vn/c;->i:Z

    if-nez p1, :cond_1

    const/4 p1, 0x1

    sput-boolean p1, Lchat/ola/vn/c;->i:Z

    invoke-static {}, Lchat/ola/vn/util/a;->b()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lcom/google/android/gms/ads/MobileAds;->initialize(Landroid/content/Context;Ljava/lang/String;)V

    :cond_1
    return-void
.end method

.method protected onDestroy()V
    .locals 1

    invoke-super {p0}, Landroid/support/v4/app/FragmentActivity;->onDestroy()V

    :try_start_0
    sget-object v0, Lchat/ola/vn/c;->b_:Lchat/ola/vn/c;

    if-ne p0, v0, :cond_0

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/c;->b_:Lchat/ola/vn/c;

    :cond_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p0}, Lchat/ola/vn/network/OlaNetworkService;->b(Lchat/ola/vn/network/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 2

    const/16 v0, 0x52

    if-ne p1, v0, :cond_1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/c;->a_:Landroid/app/Dialog;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c;->a_:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/c;->a_:Landroid/app/Dialog;

    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/c;->a_:Landroid/app/Dialog;

    return v1

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/c;->v()Landroid/app/Dialog;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/c;->a_:Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return v1

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    invoke-super {p0, p1, p2}, Landroid/support/v4/app/FragmentActivity;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result p1

    return p1
.end method

.method protected onPause()V
    .locals 4

    invoke-super {p0}, Landroid/support/v4/app/FragmentActivity;->onPause()V

    sget-object v0, Lchat/ola/vn/c;->b_:Lchat/ola/vn/c;

    if-ne p0, v0, :cond_0

    const/4 v0, 0x0

    sput-object v0, Lchat/ola/vn/c;->b_:Lchat/ola/vn/c;

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/c;->getCurrentFocus()Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_1

    const-string v1, "input_method"

    invoke-virtual {p0, v1}, Lchat/ola/vn/c;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/inputmethod/InputMethodManager;

    invoke-virtual {v0}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z

    invoke-virtual {v0}, Landroid/view/View;->clearFocus()V

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/c;->C()V

    invoke-static {p0}, Lchat/ola/vn/OlaApplication;->b(Landroid/app/Activity;)V

    return-void
.end method

.method protected final onResume()V
    .locals 6

    invoke-super {p0}, Landroid/support/v4/app/FragmentActivity;->onResume()V

    sput-object p0, Lchat/ola/vn/c;->b_:Lchat/ola/vn/c;

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/OlaApplication;->a(Landroid/content/Context;)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/network/f;)V

    :cond_0
    invoke-static {p0}, Lchat/ola/vn/OlaApplication;->a(Landroid/app/Activity;)V

    invoke-direct {p0}, Lchat/ola/vn/c;->E()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/c;->a()V

    :cond_1
    new-instance v0, Lchat/ola/vn/c$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/c$1;-><init>(Lchat/ola/vn/c;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->b(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :goto_0
    invoke-direct {p0}, Lchat/ola/vn/c;->C()V

    const/4 v0, 0x0

    :try_start_1
    sget-object v1, Lchat/ola/vn/c;->g:Ljava/lang/String;

    if-nez v1, :cond_2

    new-instance v1, Lchat/ola/vn/c$a;

    const/4 v2, 0x0

    invoke-direct {v1, p0, v2}, Lchat/ola/vn/c$a;-><init>(Lchat/ola/vn/c;Lchat/ola/vn/c$1;)V

    new-array v2, v0, [Ljava/lang/String;

    invoke-virtual {v1, v2}, Lchat/ola/vn/c$a;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    goto :goto_1

    :cond_2
    sget-object v1, Lchat/ola/vn/h;->S:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-static {p0}, Lchat/ola/vn/util/n;->j(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lchat/ola/vn/h;->S:Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_3
    :goto_1
    invoke-direct {p0}, Lchat/ola/vn/c;->D()V

    :try_start_2
    sget-boolean v1, Lchat/ola/vn/c;->j:Z

    if-nez v1, :cond_7

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x17

    if-lt v1, v2, :cond_7

    const/4 v1, 0x1

    sput-boolean v1, Lchat/ola/vn/c;->j:Z

    const/4 v2, 0x3

    new-array v2, v2, [Ljava/lang/String;

    const-string v3, "android.permission.GET_ACCOUNTS"

    aput-object v3, v2, v0

    const-string v3, "android.permission.READ_EXTERNAL_STORAGE"

    aput-object v3, v2, v1

    const/4 v1, 0x2

    const-string v3, "android.permission.WRITE_EXTERNAL_STORAGE"

    aput-object v3, v2, v1

    new-instance v1, Ljava/util/ArrayList;

    array-length v3, v2

    invoke-direct {v1, v3}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v3, 0x0

    :goto_2
    array-length v4, v2

    if-ge v3, v4, :cond_5

    aget-object v4, v2, v3

    invoke-virtual {p0, v4}, Lchat/ola/vn/c;->checkSelfPermission(Ljava/lang/String;)I

    move-result v4

    if-eqz v4, :cond_4

    aget-object v4, v2, v3

    invoke-interface {v1, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_4
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    :cond_5
    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    if-lez v2, :cond_7

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v2

    new-array v2, v2, [Ljava/lang/String;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v3

    const/4 v4, 0x0

    :goto_3
    if-ge v4, v3, :cond_6

    invoke-interface {v1, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    aput-object v5, v2, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_3

    :cond_6
    invoke-virtual {p0, v2, v0}, Lchat/ola/vn/c;->requestPermissions([Ljava/lang/String;I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :cond_7
    return-void
.end method

.method public p()V
    .locals 0

    return-void
.end method

.method public q()V
    .locals 0

    return-void
.end method

.method public r()V
    .locals 0

    return-void
.end method

.method public s()V
    .locals 0

    return-void
.end method

.method public t()V
    .locals 0

    return-void
.end method

.method public u()V
    .locals 0

    return-void
.end method

.method protected v()Landroid/app/Dialog;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public w()V
    .locals 0

    return-void
.end method

.method public z()Landroid/widget/FrameLayout;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method
