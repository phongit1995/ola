.class Lchat/ola/vn/signup/fb/a$c;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/signup/fb/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "c"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/fb/a;

.field private b:Landroid/view/View;

.field private c:Lchat/ola/vn/signup/fb/a$b;

.field private d:Lchat/ola/vn/view/OlaCachedImageView;

.field private e:Landroid/widget/TextView;

.field private f:Landroid/view/View$OnClickListener;


# direct methods
.method private constructor <init>(Lchat/ola/vn/signup/fb/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/a$c;->a:Lchat/ola/vn/signup/fb/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/signup/fb/a;Lchat/ola/vn/signup/fb/a$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/signup/fb/a$c;-><init>(Lchat/ola/vn/signup/fb/a;)V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/signup/fb/a$c;)Lchat/ola/vn/signup/fb/a$b;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/fb/a$c;->c:Lchat/ola/vn/signup/fb/a$b;

    return-object p0
.end method

.method private a()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/fb/a$c;->d:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_0

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/signup/fb/a$c;->c:Lchat/ola/vn/signup/fb/a$b;

    invoke-virtual {v1}, Lchat/ola/vn/signup/fb/a$b;->a()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    iget-object v3, p0, Lchat/ola/vn/signup/fb/a$c;->d:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/signup/fb/a$c;)Landroid/view/View$OnClickListener;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/signup/fb/a$c;->f:Landroid/view/View$OnClickListener;

    return-object p0
.end method


# virtual methods
.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/fb/a$c;->f:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Landroid/view/View;)V
    .locals 1

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/signup/fb/a$c;->b:Landroid/view/View;

    const v0, 0x7f090270

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object v0, p0, Lchat/ola/vn/signup/fb/a$c;->d:Lchat/ola/vn/view/OlaCachedImageView;

    const v0, 0x7f090570

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/signup/fb/a$c;->e:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/signup/fb/a$c;->b:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/signup/fb/a$b;)V
    .locals 1

    :try_start_0
    iput-object p1, p0, Lchat/ola/vn/signup/fb/a$c;->c:Lchat/ola/vn/signup/fb/a$b;

    invoke-direct {p0}, Lchat/ola/vn/signup/fb/a$c;->a()V

    iget-object p1, p0, Lchat/ola/vn/signup/fb/a$c;->e:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/signup/fb/a$c;->c:Lchat/ola/vn/signup/fb/a$b;

    invoke-virtual {v0}, Lchat/ola/vn/signup/fb/a$b;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    new-instance p1, Lchat/ola/vn/signup/fb/a$c$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/signup/fb/a$c$1;-><init>(Lchat/ola/vn/signup/fb/a$c;)V

    iget-object v0, p0, Lchat/ola/vn/signup/fb/a$c;->d:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/signup/fb/a$c;->e:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
