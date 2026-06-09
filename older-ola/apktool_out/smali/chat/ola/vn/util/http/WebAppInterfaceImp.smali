.class public Lchat/ola/vn/util/http/WebAppInterfaceImp;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/util/http/IWebAppInterface;


# instance fields
.field private a:Landroid/content/Context;

.field protected b:I

.field private c:Landroid/webkit/WebView;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/webkit/WebView;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp;->b:I

    iput-object p1, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp;->a:Landroid/content/Context;

    iput-object p2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp;->c:Landroid/webkit/WebView;

    return-void
.end method

.method static synthetic access$000(Lchat/ola/vn/util/http/WebAppInterfaceImp;)Landroid/content/Context;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp;->a:Landroid/content/Context;

    return-object p0
.end method

.method static synthetic access$100(Lchat/ola/vn/util/http/WebAppInterfaceImp;)Landroid/webkit/WebView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp;->c:Landroid/webkit/WebView;

    return-object p0
.end method

.method static synthetic access$200(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->jsTrim(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private jsTrim(Ljava/lang/String;)Ljava/lang/String;
    .locals 2

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    :cond_0
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    return-object v0

    :cond_1
    const-string v1, "null"

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, "undefined"

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    const-string v1, ""

    invoke-virtual {v1, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    return-object v0

    :cond_2
    return-object p1

    :cond_3
    return-object v0
.end method


# virtual methods
.method public copyToClipboard(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$3;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$3;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public createOlaMallShortcut()V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    return-void
.end method

.method public fetchHttpUrl(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start_0
    new-instance v0, Lchat/ola/vn/v/c$b;

    invoke-direct {v0}, Lchat/ola/vn/v/c$b;-><init>()V

    iput-object p1, v0, Lchat/ola/vn/v/c$b;->a:Ljava/lang/String;

    iput-object p5, v0, Lchat/ola/vn/v/c$b;->b:Ljava/lang/String;

    iput-object p3, v0, Lchat/ola/vn/v/c$b;->c:Ljava/lang/String;

    iput-object p4, v0, Lchat/ola/vn/v/c$b;->d:Ljava/lang/String;

    const-string p1, "\\|"

    invoke-virtual {p2, p1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/v/c$b;->e:[Ljava/lang/String;

    new-instance p1, Lchat/ola/vn/util/http/WebAppInterfaceImp$9;

    invoke-direct {p1, p0}, Lchat/ola/vn/util/http/WebAppInterfaceImp$9;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;)V

    iput-object p1, v0, Lchat/ola/vn/v/c$b;->g:Lchat/ola/vn/v/c$a;

    invoke-static {}, Lcom/mg/ola/common/d/g;->c()Z

    move-result p1

    const/4 p2, 0x0

    const/4 p3, 0x1

    if-eqz p1, :cond_0

    new-instance p1, Lchat/ola/vn/v/c;

    invoke-direct {p1}, Lchat/ola/vn/v/c;-><init>()V

    sget-object p4, Lchat/ola/vn/h;->R:Ljava/util/concurrent/ExecutorService;

    new-array p3, p3, [Lchat/ola/vn/v/c$b;

    aput-object v0, p3, p2

    invoke-virtual {p1, p4, p3}, Lchat/ola/vn/v/c;->executeOnExecutor(Ljava/util/concurrent/Executor;[Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void

    :cond_0
    new-instance p1, Lchat/ola/vn/v/c;

    invoke-direct {p1}, Lchat/ola/vn/v/c;-><init>()V

    new-array p3, p3, [Lchat/ola/vn/v/c$b;

    aput-object v0, p3, p2

    invoke-virtual {p1, p3}, Lchat/ola/vn/v/c;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public fetchUrl(Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v5, p2

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->fetchHttpUrl(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public fetchUrl(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 6
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v5, p3

    invoke-virtual/range {v0 .. v5}, Lchat/ola/vn/util/http/WebAppInterfaceImp;->fetchHttpUrl(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public getClientPhone(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$10;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$10;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    const-string p1, ""

    return-object p1
.end method

.method public getHtmlFromPage(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$7;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$7;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public getTopActionBarHeight(Ljava/lang/String;)I
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$20;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$20;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    const/4 p1, 0x0

    return p1
.end method

.method public hi(Ljava/lang/String;)V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    return-void
.end method

.method public onCloseApp()V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    return-void
.end method

.method public onSignInComplete(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;)V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    return-void
.end method

.method public onSignUpComplete(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    return-void
.end method

.method public onVisibleActionBar(Ljava/lang/String;)V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    return-void
.end method

.method public openApp(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$11;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/util/http/WebAppInterfaceImp$11;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public openHttp(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$1;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$1;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public openHttpTrust(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp;->a:Landroid/content/Context;

    invoke-static {v0, p1}, Lchat/ola/vn/util/b;->n(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public openMeByClan(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$17;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$17;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public openMeByNick(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$16;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$16;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public openMedia(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$18;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$18;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public openMedias([Ljava/lang/String;I)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$19;

    invoke-direct {v0, p0, p2, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$19;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;I[Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public openRss(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$12;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$12;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public playSoundUrl(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$21;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$21;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public playSoundUrls(Ljava/lang/String;II)V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance p2, Lchat/ola/vn/util/http/WebAppInterfaceImp$15;

    invoke-direct {p2, p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$15;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V

    invoke-static {p2}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public playVideoUrl(Ljava/lang/String;I)V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start_0
    iget-object p2, p0, Lchat/ola/vn/util/http/WebAppInterfaceImp;->a:Landroid/content/Context;

    invoke-static {p2, p1}, Lchat/ola/vn/util/b;->d(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public playYoutubes([Ljava/lang/String;II)V
    .locals 0
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance p3, Lchat/ola/vn/util/http/WebAppInterfaceImp$14;

    invoke-direct {p3, p0, p1, p2}, Lchat/ola/vn/util/http/WebAppInterfaceImp$14;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;[Ljava/lang/String;I)V

    invoke-static {p3}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public requestShowPostMeRssForm(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start_0
    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;

    invoke-direct {v0, p0, p3, p1, p2}, Lchat/ola/vn/util/http/WebAppInterfaceImp$4;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public sendSms(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$13;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/util/http/WebAppInterfaceImp$13;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public showPostMeForm(JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;)V
    .locals 9
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start_0
    new-instance v8, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;

    move-object v0, v8

    move-object v1, p0

    move-wide v2, p1

    move-object v4, p5

    move-object v5, p6

    move-object v6, p3

    move-object v7, p4

    invoke-direct/range {v0 .. v7}, Lchat/ola/vn/util/http/WebAppInterfaceImp$5;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;JLjava/lang/String;[Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v8}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public showReplyMeForm(JLjava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    :try_start_0
    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$6;

    invoke-direct {v0, p0, p3, p1, p2}, Lchat/ola/vn/util/http/WebAppInterfaceImp$6;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;J)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public showToast(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$8;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$8;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public startChatGroup(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$2;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$2;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public startChatOla(Ljava/lang/String;)V
    .locals 1
    .annotation runtime Landroid/webkit/JavascriptInterface;
    .end annotation

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    new-instance v0, Lchat/ola/vn/util/http/WebAppInterfaceImp$22;

    invoke-direct {v0, p0, p1}, Lchat/ola/vn/util/http/WebAppInterfaceImp$22;-><init>(Lchat/ola/vn/util/http/WebAppInterfaceImp;Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;)V

    return-void
.end method
