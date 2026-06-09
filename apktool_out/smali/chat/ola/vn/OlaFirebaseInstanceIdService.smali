.class public Lchat/ola/vn/OlaFirebaseInstanceIdService;
.super Lcom/google/firebase/iid/FirebaseInstanceIdService;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/google/firebase/iid/FirebaseInstanceIdService;-><init>()V

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .locals 2

    sput-object p1, Lchat/ola/vn/h;->f:Ljava/lang/String;

    :try_start_0
    sget-object p1, Lchat/ola/vn/h;->g:Ljava/lang/String;

    if-nez p1, :cond_0

    invoke-static {p0}, Lchat/ola/vn/util/n;->f(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p1

    sput-object p1, Lchat/ola/vn/h;->g:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    :try_start_1
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    sget-object v0, Lchat/ola/vn/h;->g:Ljava/lang/String;

    sget-object v1, Lchat/ola/vn/h;->f:Ljava/lang/String;

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->d(Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/h;->f:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lchat/ola/vn/e;->g(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    return-void
.end method


# virtual methods
.method public onTokenRefresh()V
    .locals 1

    invoke-static {}, Lcom/google/firebase/iid/FirebaseInstanceId;->getInstance()Lcom/google/firebase/iid/FirebaseInstanceId;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/firebase/iid/FirebaseInstanceId;->getToken()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lchat/ola/vn/OlaFirebaseInstanceIdService;->a(Ljava/lang/String;)V

    return-void
.end method
