.class public Lchat/ola/vn/entry/b/q;
.super Lchat/ola/vn/entry/b/l;


# instance fields
.field private a:Landroid/view/View;

.field private e:Lchat/ola/vn/view/OlaCachedImageView;

.field private f:Landroid/widget/TextView;

.field private g:Landroid/widget/TextView;

.field private h:Landroid/view/View;

.field private i:Lchat/ola/vn/entry/c;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/entry/b/l;-><init>(Landroid/view/View;)V

    const v0, 0x7f090370

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/q;->a:Landroid/view/View;

    const v0, 0x7f09029f

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/q;->e:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f09036f

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/entry/b/q;->h:Landroid/view/View;

    const v0, 0x7f090371

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lchat/ola/vn/entry/b/q;->f:Landroid/widget/TextView;

    const v0, 0x7f09036e

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/entry/b/q;->g:Landroid/widget/TextView;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/entry/b/q;)Lchat/ola/vn/entry/c;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/q;->i:Lchat/ola/vn/entry/c;

    return-object p0
.end method

.method private a()V
    .locals 3
    .annotation build Landroid/annotation/TargetApi;
        value = 0xb
    .end annotation

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "http://img.youtube.com/vi/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/entry/b/q;->i:Lchat/ola/vn/entry/c;

    invoke-virtual {v1}, Lchat/ola/vn/entry/c;->d()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, "/mqdefault.jpg"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/q;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1}, Lchat/ola/vn/view/OlaCachedImageView;->getWidth()I

    move-result v1

    const/16 v2, 0x190

    if-le v1, v2, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "http://img.youtube.com/vi/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v1, p0, Lchat/ola/vn/entry/b/q;->i:Lchat/ola/vn/entry/c;

    invoke-virtual {v1}, Lchat/ola/vn/entry/c;->d()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, "/hqdefault.jpg"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_0
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/entry/b/q;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/q;->a:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/q;->i:Lchat/ola/vn/entry/c;

    invoke-virtual {v0}, Lchat/ola/vn/entry/c;->f()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/q;->h:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/q;->f:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/q;->i:Lchat/ola/vn/entry/c;

    invoke-virtual {v1}, Lchat/ola/vn/entry/c;->f()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/q;->g:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/entry/b/q;->i:Lchat/ola/vn/entry/c;

    invoke-virtual {v1}, Lchat/ola/vn/entry/c;->g()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/q;->h:Landroid/view/View;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/q;->f:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/q;->g:Landroid/widget/TextView;

    const-string v1, ""

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :try_start_0
    new-instance v0, Lchat/ola/vn/entry/b/q$1;

    invoke-direct {v0, p0}, Lchat/ola/vn/entry/b/q$1;-><init>(Lchat/ola/vn/entry/b/q;)V

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v2, p0, Lchat/ola/vn/entry/b/q;->i:Lchat/ola/vn/entry/c;

    invoke-virtual {v2}, Lchat/ola/vn/entry/c;->d()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Lchat/ola/vn/p/o;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/entry/b/q;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/q;->h:Landroid/view/View;

    return-object p0
.end method

.method static synthetic c(Lchat/ola/vn/entry/b/q;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/q;->f:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic d(Lchat/ola/vn/entry/b/q;)Landroid/widget/TextView;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/entry/b/q;->g:Landroid/widget/TextView;

    return-object p0
.end method


# virtual methods
.method public a(Lchat/ola/vn/entry/c;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/q;->i:Lchat/ola/vn/entry/c;

    iget-object p2, p0, Lchat/ola/vn/entry/b/q;->e:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p2, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/q;->e:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object p2, p0, Lchat/ola/vn/entry/b/q;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, p2}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-direct {p0}, Lchat/ola/vn/entry/b/q;->a()V

    return-void
.end method
