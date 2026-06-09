.class public Lchat/ola/vn/OlaApplication;
.super Landroid/app/Application;

# interfaces
.implements Lchat/ola/vn/f/a;


# annotations
.annotation build Landroid/annotation/SuppressLint;
    value = {
        "DefaultLocale",
        "NewApi"
    }
.end annotation


# static fields
.field public static a:Ljava/lang/String; = "Ola"

.field public static b:Lchat/ola/vn/network/OlaNetworkService; = null

.field public static c:Lchat/ola/vn/balloon/OlaBalloonService; = null

.field public static d:Z = false

.field private static e:Landroid/content/Context; = null

.field private static f:Landroid/os/Handler; = null

.field private static g:Ljava/lang/Runnable; = null

.field private static h:J = 0x0L

.field private static i:Z = false


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method

.method public static a()Landroid/content/Context;
    .locals 1

    sget-object v0, Lchat/ola/vn/OlaApplication;->e:Landroid/content/Context;

    return-object v0
.end method

.method public static a(I)Ljava/lang/String;
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->c()V

    sget-object v0, Lchat/ola/vn/OlaApplication;->e:Landroid/content/Context;

    invoke-virtual {v0, p0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    const-string p0, ""

    return-object p0
.end method

.method public static varargs a(I[Ljava/lang/Object;)Ljava/lang/String;
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0, p0, p1}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->c()V

    sget-object v0, Lchat/ola/vn/OlaApplication;->e:Landroid/content/Context;

    invoke-virtual {v0, p0, p1}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    const-string p0, ""

    return-object p0
.end method

.method public static a(Landroid/app/Activity;)V
    .locals 4

    sget-wide v0, Lchat/ola/vn/OlaApplication;->h:J

    const-wide/16 v2, 0x0

    cmp-long p0, v0, v2

    if-nez p0, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sput-wide v0, Lchat/ola/vn/OlaApplication;->h:J

    :cond_0
    const/4 p0, 0x1

    sput-boolean p0, Lchat/ola/vn/OlaApplication;->i:Z

    :try_start_0
    sget-object p0, Lchat/ola/vn/OlaApplication;->g:Ljava/lang/Runnable;

    if-eqz p0, :cond_1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->g()Landroid/os/Handler;

    move-result-object p0

    sget-object v0, Lchat/ola/vn/OlaApplication;->g:Ljava/lang/Runnable;

    invoke-virtual {p0, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    :try_start_1
    sget-object p0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p0}, Lchat/ola/vn/message/g;->p()Ljava/util/List;

    move-result-object p0

    invoke-interface {p0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->A()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_1
    :cond_2
    return-void
.end method

.method public static a(Landroid/content/Context;)V
    .locals 4

    :try_start_0
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/c/x;->i()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v2

    iget-object v3, v2, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v3}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    new-instance v3, Ljava/util/Locale;

    invoke-direct {v3, v1}, Ljava/util/Locale;-><init>(Ljava/lang/String;)V

    iput-object v3, v2, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {p0, v2, v0}, Landroid/content/res/Resources;->updateConfiguration(Landroid/content/res/Configuration;Landroid/util/DisplayMetrics;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public static a(Ljava/lang/Runnable;)V
    .locals 1

    invoke-static {}, Lchat/ola/vn/OlaApplication;->g()Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public static a(Ljava/lang/Runnable;J)V
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->g()Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0, p1, p2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static b()Landroid/content/res/Resources;
    .locals 1

    sget-object v0, Lchat/ola/vn/OlaApplication;->e:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    return-object v0
.end method

.method private b(Landroid/content/Context;)Ljava/lang/String;
    .locals 1

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/e;->p()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/google/firebase/iid/FirebaseInstanceId;->getInstance()Lcom/google/firebase/iid/FirebaseInstanceId;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/firebase/iid/FirebaseInstanceId;->getToken()Ljava/lang/String;

    move-result-object p1

    :cond_0
    return-object p1
.end method

.method public static b(Ljava/lang/Runnable;J)Ljava/util/concurrent/ScheduledFuture;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Runnable;",
            "J)",
            "Ljava/util/concurrent/ScheduledFuture<",
            "*>;"
        }
    .end annotation

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->P:Ljava/util/concurrent/ScheduledExecutorService;

    sget-object v1, Ljava/util/concurrent/TimeUnit;->MILLISECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-interface {v0, p0, p1, p2, v1}, Ljava/util/concurrent/ScheduledExecutorService;->schedule(Ljava/lang/Runnable;JLjava/util/concurrent/TimeUnit;)Ljava/util/concurrent/ScheduledFuture;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static b(I)V
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0, p0}, Lchat/ola/vn/util/c/b;->b(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static b(Landroid/app/Activity;)V
    .locals 3

    const/4 p0, 0x0

    sput-boolean p0, Lchat/ola/vn/OlaApplication;->i:Z

    :try_start_0
    sget-object p0, Lchat/ola/vn/OlaApplication;->g:Ljava/lang/Runnable;

    if-eqz p0, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->g()Landroid/os/Handler;

    move-result-object p0

    sget-object v0, Lchat/ola/vn/OlaApplication;->g:Ljava/lang/Runnable;

    invoke-virtual {p0, v0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    goto :goto_0

    :cond_0
    new-instance p0, Lchat/ola/vn/OlaApplication$1;

    invoke-direct {p0}, Lchat/ola/vn/OlaApplication$1;-><init>()V

    sput-object p0, Lchat/ola/vn/OlaApplication;->g:Ljava/lang/Runnable;

    :goto_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->g()Landroid/os/Handler;

    move-result-object p0

    sget-object v0, Lchat/ola/vn/OlaApplication;->g:Ljava/lang/Runnable;

    const-wide/16 v1, 0x7d0

    invoke-virtual {p0, v0, v1, v2}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static b(Ljava/lang/Runnable;)V
    .locals 0

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/h;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public static c()V
    .locals 5

    :try_start_0
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/c/x;->i()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->e:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v3

    iget-object v4, v3, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v4}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v4

    invoke-static {v1, v4}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_0

    new-instance v4, Ljava/util/Locale;

    invoke-direct {v4, v1}, Ljava/util/Locale;-><init>(Ljava/lang/String;)V

    iput-object v4, v3, Landroid/content/res/Configuration;->locale:Ljava/util/Locale;

    invoke-virtual {v0, v3, v2}, Landroid/content/res/Resources;->updateConfiguration(Landroid/content/res/Configuration;Landroid/util/DisplayMetrics;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public static c(Ljava/lang/Runnable;)V
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->g()Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public static d()V
    .locals 4

    :try_start_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    const-wide/16 v2, 0x0

    sput-wide v2, Lchat/ola/vn/OlaApplication;->h:J

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    sput-object v2, Lchat/ola/vn/c;->d_:Ljava/lang/Long;

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v2

    invoke-virtual {v2, v0, v1}, Lchat/ola/vn/e;->c(J)V

    new-instance v0, Lchat/ola/vn/v/b;

    invoke-direct {v0}, Lchat/ola/vn/v/b;-><init>()V

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/v/b;->a(Ljava/lang/String;)V

    sget v1, Lchat/ola/vn/h;->r:I

    invoke-virtual {v0, v1}, Lchat/ola/vn/v/b;->a(I)V

    sget v1, Lchat/ola/vn/h;->G:I

    invoke-virtual {v0, v1}, Lchat/ola/vn/v/b;->b(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    const/4 v1, 0x0

    :try_start_1
    new-instance v2, Lchat/ola/vn/v/a;

    invoke-direct {v2}, Lchat/ola/vn/v/a;-><init>()V

    const/4 v3, 0x1

    new-array v3, v3, [Lchat/ola/vn/v/b;

    aput-object v0, v3, v1

    invoke-virtual {v2, v3}, Lchat/ola/vn/v/a;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->q()I

    move-result v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    :catch_1
    const/4 v0, 0x0

    :goto_0
    :try_start_3
    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->b(I)V

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    :cond_0
    return-void
.end method

.method public static e()Z
    .locals 1

    sget-boolean v0, Lchat/ola/vn/OlaApplication;->i:Z

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public static f()Ljava/lang/String;
    .locals 1

    const-string v0, "chat.ola.vn"

    return-object v0
.end method

.method public static g()Landroid/os/Handler;
    .locals 2

    sget-object v0, Lchat/ola/vn/OlaApplication;->f:Landroid/os/Handler;

    if-nez v0, :cond_0

    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    sput-object v0, Lchat/ola/vn/OlaApplication;->f:Landroid/os/Handler;

    :cond_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->f:Landroid/os/Handler;

    return-object v0
.end method

.method private h()I
    .locals 6

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/OlaApplication;->getResources()Landroid/content/res/Resources;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    const-string v1, "status_bar_height"

    const-string v2, "dimen"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    if-lez v1, :cond_0

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v1

    return v1

    :cond_0
    const/high16 v1, 0x41c80000    # 25.0f

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    iget v2, v2, Landroid/util/DisplayMetrics;->density:F

    mul-float v2, v2, v1

    float-to-double v1, v2

    invoke-static {v1, v2}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    double-to-int v0, v1

    return v0

    :catch_0
    const/16 v1, 0x13

    const/16 v2, 0x19

    const/16 v3, 0x26

    const/16 v4, 0x32

    :try_start_2
    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->densityDpi:I

    const/16 v5, 0x78

    if-eq v0, v5, :cond_4

    const/16 v1, 0xa0

    if-eq v0, v1, :cond_3

    const/16 v1, 0xf0

    if-eq v0, v1, :cond_2

    const/16 v1, 0x140

    if-eq v0, v1, :cond_1

    const/16 v1, 0x1e0

    if-eq v0, v1, :cond_1

    sget v0, Lchat/ola/vn/h;->z:I
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return v0

    :cond_1
    return v4

    :cond_2
    return v3

    :cond_3
    return v2

    :cond_4
    return v1

    :catch_1
    const/16 v0, 0x4b

    return v0
.end method

.method private i()V
    .locals 3

    :try_start_0
    invoke-static {}, Lcom/google/android/gms/common/GoogleApiAvailability;->getInstance()Lcom/google/android/gms/common/GoogleApiAvailability;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/google/android/gms/common/GoogleApiAvailability;->isGooglePlayServicesAvailable(Landroid/content/Context;)I

    move-result v1

    if-nez v1, :cond_0

    invoke-direct {p0, p0}, Lchat/ola/vn/OlaApplication;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/h;->f:Ljava/lang/String;

    return-void

    :cond_0
    invoke-virtual {v0, v1}, Lcom/google/android/gms/common/GoogleApiAvailability;->isUserResolvableError(I)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {v0, p0, v1}, Lcom/google/android/gms/common/GoogleApiAvailability;->showErrorNotification(Landroid/content/Context;I)V

    return-void

    :cond_1
    invoke-static {p0}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private j()V
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/c/t;->b()V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/c/t;->c()V

    invoke-static {}, Lchat/ola/vn/activity/OlaBottomTabActivity;->E()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0

    invoke-super {p0, p1}, Landroid/app/Application;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    invoke-static {}, Lchat/ola/vn/OlaApplication;->c()V

    return-void
.end method

.method public onCreate()V
    .locals 7
    .annotation build Landroid/annotation/SuppressLint;
        value = {
            "NewApi"
        }
    .end annotation

    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    invoke-static {}, Lchat/ola/vn/util/a;->a()V

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/f;->a(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_5

    :try_start_1
    const-string v0, "http.keepAlive"

    const-string v1, "true"

    invoke-static {v0, v1}, Ljava/lang/System;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    const-string v0, "http.maxConnections"

    const-string v1, "12"

    invoke-static {v0, v1}, Ljava/lang/System;->setProperty(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    const v0, 0x7f0f0023

    :try_start_2
    invoke-virtual {p0, v0}, Lchat/ola/vn/OlaApplication;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    sput-object v0, Lchat/ola/vn/OlaApplication;->a:Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_0
    const-wide/16 v0, 0x2710

    :try_start_3
    invoke-static {v0, v1}, Lchat/ola/vn/util/j;->a(J)V

    sput-object p0, Lchat/ola/vn/OlaApplication;->e:Landroid/content/Context;

    invoke-static {p0}, Lchat/ola/vn/util/n;->f(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lchat/ola/vn/h;->g:Ljava/lang/String;

    invoke-static {}, Lchat/ola/vn/OlaApplication;->c()V

    invoke-static {p0}, Lchat/ola/vn/util/n;->c(Landroid/content/Context;)Z

    move-result v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eqz v0, :cond_2

    sput-boolean v2, Lchat/ola/vn/h;->F:Z
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_5

    :try_start_4
    const-string v0, "connectivity"

    invoke-virtual {p0, v0}, Lchat/ola/vn/OlaApplication;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v0

    invoke-virtual {v0}, Landroid/net/NetworkInfo;->getType()I

    move-result v0

    if-ne v0, v2, :cond_1

    sput-boolean v2, Lchat/ola/vn/h;->I:Z

    goto :goto_0

    :cond_1
    sput-boolean v1, Lchat/ola/vn/h;->I:Z
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_0

    :cond_2
    :try_start_5
    sput-boolean v1, Lchat/ola/vn/h;->F:Z

    :catch_2
    :goto_0
    invoke-direct {p0}, Lchat/ola/vn/OlaApplication;->i()V

    new-instance v0, Landroid/content/Intent;

    const-class v3, Lchat/ola/vn/network/OlaNetworkService;

    invoke-direct {v0, p0, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lchat/ola/vn/OlaApplication;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    new-instance v0, Landroid/content/Intent;

    const-class v3, Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-direct {v0, p0, v3}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lchat/ola/vn/OlaApplication;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_5

    :try_start_6
    const-string v0, "window"

    invoke-virtual {p0, v0}, Lchat/ola/vn/OlaApplication;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    new-instance v3, Landroid/util/DisplayMetrics;

    invoke-direct {v3}, Landroid/util/DisplayMetrics;-><init>()V

    invoke-virtual {v0, v3}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    const-string v4, "phone"

    invoke-virtual {p0, v4}, Lchat/ola/vn/OlaApplication;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/telephony/TelephonyManager;
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_6

    :try_start_7
    invoke-virtual {v4}, Landroid/telephony/TelephonyManager;->getLine1Number()Ljava/lang/String;

    move-result-object v5

    sput-object v5, Lchat/ola/vn/h;->S:Ljava/lang/String;
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_3

    :catch_3
    :try_start_8
    invoke-static {}, Lcom/mg/ola/common/d/g;->e()Z

    move-result v5

    if-eqz v5, :cond_3

    new-instance v5, Landroid/graphics/Point;

    invoke-direct {v5}, Landroid/graphics/Point;-><init>()V

    invoke-virtual {v0, v5}, Landroid/view/Display;->getSize(Landroid/graphics/Point;)V

    iget v0, v5, Landroid/graphics/Point;->x:I

    sput v0, Lchat/ola/vn/e;->c:I

    sget v0, Lchat/ola/vn/e;->c:I

    int-to-float v0, v0

    iget v6, v3, Landroid/util/DisplayMetrics;->density:F

    div-float/2addr v0, v6

    float-to-int v0, v0

    sput v0, Lchat/ola/vn/e;->a:I

    iget v0, v5, Landroid/graphics/Point;->y:I

    sput v0, Lchat/ola/vn/e;->d:I

    sget v0, Lchat/ola/vn/e;->d:I

    :goto_1
    int-to-float v0, v0

    iget v3, v3, Landroid/util/DisplayMetrics;->density:F

    div-float/2addr v0, v3

    float-to-int v0, v0

    sput v0, Lchat/ola/vn/e;->b:I

    goto :goto_2

    :cond_3
    invoke-virtual {v0}, Landroid/view/Display;->getWidth()I

    move-result v5

    sput v5, Lchat/ola/vn/e;->c:I

    sget v5, Lchat/ola/vn/e;->c:I

    int-to-float v5, v5

    iget v6, v3, Landroid/util/DisplayMetrics;->density:F

    div-float/2addr v5, v6

    float-to-int v5, v5

    sput v5, Lchat/ola/vn/e;->a:I

    invoke-virtual {v0}, Landroid/view/Display;->getHeight()I

    move-result v0

    sput v0, Lchat/ola/vn/e;->d:I

    sget v0, Lchat/ola/vn/e;->d:I
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_6

    goto :goto_1

    :goto_2
    :try_start_9
    sget-boolean v0, Lchat/ola/vn/h;->I:Z

    if-nez v0, :cond_5

    sput-boolean v2, Lchat/ola/vn/h;->J:Z

    invoke-virtual {v4}, Landroid/telephony/TelephonyManager;->getNetworkType()I

    move-result v0

    if-eq v0, v2, :cond_4

    invoke-virtual {v4}, Landroid/telephony/TelephonyManager;->getNetworkType()I

    move-result v0

    const/4 v2, 0x2

    if-ne v0, v2, :cond_5

    :cond_4
    sput-boolean v1, Lchat/ola/vn/h;->J:Z
    :try_end_9
    .catch Ljava/lang/Throwable; {:try_start_9 .. :try_end_9} :catch_4

    :catch_4
    :cond_5
    :try_start_a
    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-virtual {p0}, Lchat/ola/vn/OlaApplication;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x1050005

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    sput v0, Lchat/ola/vn/h;->A:I

    invoke-virtual {p0}, Lchat/ola/vn/OlaApplication;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const v1, 0x1050006

    invoke-virtual {v0, v1}, Landroid/content/res/Resources;->getDimensionPixelSize(I)I

    move-result v0

    sput v0, Lchat/ola/vn/h;->z:I

    :cond_6
    invoke-direct {p0}, Lchat/ola/vn/OlaApplication;->h()I

    move-result v0

    sput v0, Lchat/ola/vn/e;->e:I
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_6

    goto :goto_3

    :catch_5
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_6
    :goto_3
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/c/b;->f(Landroid/content/Context;)V

    :try_start_b
    invoke-virtual {p0}, Lchat/ola/vn/OlaApplication;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/facebook/FacebookSdk;->sdkInitialize(Landroid/content/Context;)V

    invoke-static {p0}, Lcom/facebook/appevents/AppEventsLogger;->activateApp(Landroid/app/Application;)V

    invoke-static {p0}, Lcom/facebook/appevents/AppEventsLogger;->newLogger(Landroid/content/Context;)Lcom/facebook/appevents/AppEventsLogger;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/util/f;->a()Lchat/ola/vn/util/f;

    move-result-object v1

    invoke-virtual {v1, v0}, Lchat/ola/vn/util/f;->a(Lcom/facebook/appevents/AppEventsLogger;)V
    :try_end_b
    .catch Ljava/lang/Throwable; {:try_start_b .. :try_end_b} :catch_7

    :catch_7
    return-void
.end method

.method public onLowMemory()V
    .locals 1

    invoke-super {p0}, Landroid/app/Application;->onLowMemory()V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/c/t;->b()V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/c/t;->c()V

    return-void
.end method

.method public onTrimMemory(I)V
    .locals 1

    invoke-super {p0, p1}, Landroid/app/Application;->onTrimMemory(I)V

    const/16 v0, 0xa

    if-eq p1, v0, :cond_1

    const/16 v0, 0xf

    if-eq p1, v0, :cond_2

    const/16 v0, 0x14

    if-eq p1, v0, :cond_2

    const/16 v0, 0x28

    if-eq p1, v0, :cond_1

    const/16 v0, 0x3c

    if-eq p1, v0, :cond_0

    const/16 v0, 0x50

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/OlaApplication;->j()V

    return-void

    :cond_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/c/t;->b()V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/c/t;->c()V

    :cond_2
    return-void
.end method
