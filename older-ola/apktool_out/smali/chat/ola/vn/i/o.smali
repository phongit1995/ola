.class public Lchat/ola/vn/i/o;
.super Lchat/ola/vn/i/n;

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private a:Landroid/webkit/WebView;

.field private b:Landroid/view/View;

.field private c:Landroid/widget/Button;

.field private d:Landroid/widget/Button;

.field private e:Ljava/lang/Runnable;

.field private f:Ljava/lang/Runnable;


# direct methods
.method public constructor <init>(Landroid/content/Context;ILjava/lang/String;)V
    .locals 6

    invoke-direct {p0, p1}, Lchat/ola/vn/i/n;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/i/o;->j:Z

    const p1, 0x7f0b0033

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/o;->setContentView(I)V

    const p1, 0x7f09052a

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/o;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/AutoScrollTextView;

    invoke-virtual {p1, p2}, Lchat/ola/vn/view/AutoScrollTextView;->setText(I)V

    const p1, 0x7f090095

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/o;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/i/o;->b:Landroid/view/View;

    const p1, 0x7f0900da

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/o;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/i/o;->c:Landroid/widget/Button;

    const p1, 0x7f090117

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/o;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/i/o;->d:Landroid/widget/Button;

    iget-object p1, p0, Lchat/ola/vn/i/o;->c:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/i/o;->d:Landroid/widget/Button;

    invoke-virtual {p1, p0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f0900ad

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/o;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p1, 0x7f09060a

    invoke-virtual {p0, p1}, Lchat/ola/vn/i/o;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/webkit/WebView;

    iput-object p1, p0, Lchat/ola/vn/i/o;->a:Landroid/webkit/WebView;

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object p1

    invoke-virtual {p1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object p1

    invoke-virtual {p1, p3}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object p1

    sget-object p2, Lcom/mg/ola/common/d/a;->f:Ljava/nio/charset/Charset;

    invoke-static {p1, p2}, Lcom/mg/ola/common/d/e;->a(Ljava/io/InputStream;Ljava/nio/charset/Charset;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/i/o;->a:Landroid/webkit/WebView;

    const-string v1, "file:///android_asset/"

    const-string v3, "text/html"

    const-string v4, "UTF-8"

    const/4 v5, 0x0

    invoke-virtual/range {v0 .. v5}, Landroid/webkit/WebView;->loadDataWithBaseURL(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method public static a(Landroid/content/Context;ILjava/lang/String;)Lchat/ola/vn/i/o;
    .locals 1

    new-instance v0, Lchat/ola/vn/i/o;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/i/o;-><init>(Landroid/content/Context;ILjava/lang/String;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/o;->show()V

    return-object v0
.end method


# virtual methods
.method public a(ILjava/lang/Runnable;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/i/o;->b:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/i/o;->c:Landroid/widget/Button;

    invoke-virtual {v0, p1}, Landroid/widget/Button;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/i/o;->c:Landroid/widget/Button;

    invoke-virtual {p1, v1}, Landroid/widget/Button;->setVisibility(I)V

    iput-object p2, p0, Lchat/ola/vn/i/o;->e:Ljava/lang/Runnable;

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 1

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    const v0, 0x7f0900ad

    if-eq p1, v0, :cond_2

    const v0, 0x7f0900da

    if-eq p1, v0, :cond_1

    const v0, 0x7f090117

    if-eq p1, v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/i/o;->dismiss()V

    iget-object p1, p0, Lchat/ola/vn/i/o;->f:Ljava/lang/Runnable;

    :goto_0
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/i/o;->dismiss()V

    iget-object p1, p0, Lchat/ola/vn/i/o;->e:Ljava/lang/Runnable;

    goto :goto_0

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/i/o;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
