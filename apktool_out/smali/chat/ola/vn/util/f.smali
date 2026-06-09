.class public Lchat/ola/vn/util/f;
.super Ljava/lang/Object;


# static fields
.field private static a:Lchat/ola/vn/util/f;


# instance fields
.field private b:Lcom/facebook/appevents/AppEventsLogger;


# direct methods
.method private constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/util/f;->b:Lcom/facebook/appevents/AppEventsLogger;

    return-void
.end method

.method public static a()Lchat/ola/vn/util/f;
    .locals 1

    sget-object v0, Lchat/ola/vn/util/f;->a:Lchat/ola/vn/util/f;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/util/f;

    invoke-direct {v0}, Lchat/ola/vn/util/f;-><init>()V

    sput-object v0, Lchat/ola/vn/util/f;->a:Lchat/ola/vn/util/f;

    :cond_0
    sget-object v0, Lchat/ola/vn/util/f;->a:Lchat/ola/vn/util/f;

    return-object v0
.end method


# virtual methods
.method public a(I)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/f;->b:Lcom/facebook/appevents/AppEventsLogger;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "FAIL_ADMOB_REASON: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/facebook/appevents/AppEventsLogger;->logEvent(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lcom/facebook/appevents/AppEventsLogger;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/f;->b:Lcom/facebook/appevents/AppEventsLogger;

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/util/f;->b:Lcom/facebook/appevents/AppEventsLogger;

    const-string v0, "LINK_CLICKED"

    invoke-virtual {p1, v0}, Lcom/facebook/appevents/AppEventsLogger;->logEvent(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;J)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/f;->b:Lcom/facebook/appevents/AppEventsLogger;

    long-to-double p2, p2

    invoke-virtual {v0, p1, p2, p3}, Lcom/facebook/appevents/AppEventsLogger;->logEvent(Ljava/lang/String;D)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/f;->b:Lcom/facebook/appevents/AppEventsLogger;

    const-string v1, "FB_PROFILE_PICTURE"

    invoke-virtual {v0, v1}, Lcom/facebook/appevents/AppEventsLogger;->logEvent(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/util/f;->b:Lcom/facebook/appevents/AppEventsLogger;

    const-string v0, "LINK_APPROVED"

    invoke-virtual {p1, v0}, Lcom/facebook/appevents/AppEventsLogger;->logEvent(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/f;->b:Lcom/facebook/appevents/AppEventsLogger;

    const-string v1, "FB_COVER_PICTURE"

    invoke-virtual {v0, v1}, Lcom/facebook/appevents/AppEventsLogger;->logEvent(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/f;->b:Lcom/facebook/appevents/AppEventsLogger;

    invoke-virtual {v0, p1}, Lcom/facebook/appevents/AppEventsLogger;->logEvent(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
