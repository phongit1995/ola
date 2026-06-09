.class Lchat/ola/vn/b/t$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/t;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field a:Lchat/ola/vn/view/OlaCachedImageView;

.field b:Landroid/widget/ImageView;

.field c:Landroid/widget/TextView;

.field d:Lchat/ola/vn/h/a;

.field final synthetic e:Lchat/ola/vn/b/t;


# direct methods
.method public constructor <init>(Lchat/ola/vn/b/t;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/t$a;->e:Lchat/ola/vn/b/t;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f09027c

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/b/t$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f09025a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/b/t$a;->b:Landroid/widget/ImageView;

    const p1, 0x7f0904e6

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/t$a;->c:Landroid/widget/TextView;

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/h/a;)V
    .locals 3

    iput-object p1, p0, Lchat/ola/vn/b/t$a;->d:Lchat/ola/vn/h/a;

    iget-object p1, p0, Lchat/ola/vn/b/t$a;->d:Lchat/ola/vn/h/a;

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/b/t$a;->e:Lchat/ola/vn/b/t;

    invoke-static {p1}, Lchat/ola/vn/b/t;->a(Lchat/ola/vn/b/t;)Landroid/view/View$OnClickListener;

    move-result-object p1

    if-eqz p1, :cond_1

    new-instance p1, Lchat/ola/vn/b/t$a$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/b/t$a$1;-><init>(Lchat/ola/vn/b/t$a;)V

    iget-object v0, p0, Lchat/ola/vn/b/t$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, p1}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/b/t$a;->c:Landroid/widget/TextView;

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/b/t$a;->b:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/b/t$a;->d:Lchat/ola/vn/h/a;

    iget-object v0, v0, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v0, v0, Landroid/accounts/Account;->name:Ljava/lang/String;

    const/4 v1, 0x0

    iget-object v2, p0, Lchat/ola/vn/b/t$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v0, v1, v2}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;)V

    iget-object p1, p0, Lchat/ola/vn/b/t$a;->c:Landroid/widget/TextView;

    iget-object v0, p0, Lchat/ola/vn/b/t$a;->d:Lchat/ola/vn/h/a;

    iget-object v0, v0, Lchat/ola/vn/h/a;->a:Landroid/accounts/Account;

    iget-object v0, v0, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method
