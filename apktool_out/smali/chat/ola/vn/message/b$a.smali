.class public Lchat/ola/vn/message/b$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/message/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "a"
.end annotation


# instance fields
.field protected a:Lchat/ola/vn/view/OlaCachedImageView;

.field protected b:Landroid/widget/TextView;

.field protected c:Landroid/widget/Button;

.field protected d:Landroid/view/View;

.field final synthetic e:Lchat/ola/vn/message/b;

.field private f:Lchat/ola/vn/message/f;


# direct methods
.method protected constructor <init>(Lchat/ola/vn/message/b;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/b$a;->e:Lchat/ola/vn/message/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f0903e3

    :try_start_0
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/message/b$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f0901b9

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/message/b$a;->b:Landroid/widget/TextView;

    const p1, 0x7f0905b8

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/message/b$a;->c:Landroid/widget/Button;

    const p1, 0x7f0905fa

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/message/b$a;->d:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/message/b$a;->f:Lchat/ola/vn/message/f;

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/message/b$a;->c:Landroid/widget/Button;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/message/b$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const v1, 0x7f0806a5

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/message/b$a;->e:Lchat/ola/vn/message/b;

    iget-object v0, v0, Lchat/ola/vn/message/b;->b:Landroid/view/View$OnClickListener;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/message/b$a;->c:Landroid/widget/Button;

    iget-object v1, p0, Lchat/ola/vn/message/b$a;->f:Lchat/ola/vn/message/f;

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/message/b$a;->d:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/message/b$a;->f:Lchat/ola/vn/message/f;

    invoke-virtual {v0, v1}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/message/b$a;->c:Landroid/widget/Button;

    iget-object v1, p0, Lchat/ola/vn/message/b$a;->e:Lchat/ola/vn/message/b;

    iget-object v1, v1, Lchat/ola/vn/message/b;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/message/b$a;->d:Landroid/view/View;

    iget-object v1, p0, Lchat/ola/vn/message/b$a;->e:Lchat/ola/vn/message/b;

    iget-object v1, v1, Lchat/ola/vn/message/b;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/message/b$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    if-eqz v0, :cond_2

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/message/b$a;->f:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    iget-object v3, p0, Lchat/ola/vn/message/b$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/c/t;->a(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;)V

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/message/b$a;->b:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/message/b$a;->f:Lchat/ola/vn/message/f;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/message/b$a;->f:Lchat/ola/vn/message/f;

    return-void
.end method
