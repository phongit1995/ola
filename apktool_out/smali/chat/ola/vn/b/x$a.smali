.class Lchat/ola/vn/b/x$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/x;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field a:Lchat/ola/vn/view/OlaCachedImageView;

.field b:Landroid/widget/TextView;

.field c:Landroid/widget/TextView;

.field d:Landroid/widget/TextView;

.field e:Landroid/widget/ImageView;

.field f:Landroid/view/View;

.field g:Landroid/widget/Button;

.field h:Landroid/widget/Button;

.field i:Lchat/ola/vn/entity/j;

.field final synthetic j:Lchat/ola/vn/b/x;


# direct methods
.method constructor <init>(Lchat/ola/vn/b/x;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/x$a;->j:Lchat/ola/vn/b/x;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f09027c

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/b/x$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f09059a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/x$a;->b:Landroid/widget/TextView;

    const p1, 0x7f09058c

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/x$a;->c:Landroid/widget/TextView;

    const p1, 0x7f090598

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/x$a;->d:Landroid/widget/TextView;

    const p1, 0x7f090250

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/b/x$a;->e:Landroid/widget/ImageView;

    const p1, 0x7f09037b

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/x$a;->f:Landroid/view/View;

    const p1, 0x7f090379

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/b/x$a;->g:Landroid/widget/Button;

    const p1, 0x7f09037a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/b/x$a;->h:Landroid/widget/Button;

    invoke-virtual {p2, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/j;)V
    .locals 8

    iput-object p1, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    if-nez p1, :cond_0

    return-void

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object p1, p1, Lchat/ola/vn/entity/j;->b:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    const/16 v2, 0x8

    const/4 v3, 0x0

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->c:Landroid/widget/TextView;

    invoke-virtual {p1, v3}, Landroid/widget/TextView;->setVisibility(I)V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object v4, v4, Lchat/ola/vn/entity/j;->b:Ljava/lang/String;

    invoke-virtual {p1, v4, v3}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->c:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object p1

    invoke-virtual {v4, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/b/x$a;->c:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object v4, v4, Lchat/ola/vn/entity/j;->b:Ljava/lang/String;

    invoke-virtual {p1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/b/x$a;->c:Landroid/widget/TextView;

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object p1, p1, Lchat/ola/vn/entity/j;->i:[B

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object p1, p1, Lchat/ola/vn/entity/j;->i:[B

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object v4, v4, Lchat/ola/vn/entity/j;->i:[B

    array-length v4, v4

    invoke-static {p1, v3, v4}, Landroid/graphics/BitmapFactory;->decodeByteArray([BII)Landroid/graphics/Bitmap;

    move-result-object p1

    if-eqz p1, :cond_3

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v5, 0x0

    invoke-virtual {v4, p1, v5}, Lchat/ola/vn/view/OlaCachedImageView;->a(Landroid/graphics/Bitmap;Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    goto :goto_1

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/b/x$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v2}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    goto :goto_1

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object p1, p1, Lchat/ola/vn/entity/j;->b:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v3}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object p1

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object v4, v4, Lchat/ola/vn/entity/j;->b:Ljava/lang/String;

    iget-object v5, p0, Lchat/ola/vn/b/x$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {p1, v4, v5}, Lchat/ola/vn/c/t;->g(Ljava/lang/String;Lchat/ola/vn/view/OlaCachedImageView;)V

    goto :goto_1

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/b/x$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const v4, 0x7f0806a5

    invoke-virtual {p1, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/b/x$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    invoke-virtual {p1, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->b:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    invoke-virtual {p1, v4}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->g:Landroid/widget/Button;

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    invoke-virtual {p1, v4}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->h:Landroid/widget/Button;

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    invoke-virtual {p1, v4}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->j:Lchat/ola/vn/b/x;

    invoke-static {v4}, Lchat/ola/vn/b/x;->a(Lchat/ola/vn/b/x;)Landroid/view/View$OnClickListener;

    move-result-object v4

    invoke-virtual {p1, v4}, Lchat/ola/vn/view/OlaCachedImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->g:Landroid/widget/Button;

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->j:Lchat/ola/vn/b/x;

    invoke-static {v4}, Lchat/ola/vn/b/x;->a(Lchat/ola/vn/b/x;)Landroid/view/View$OnClickListener;

    move-result-object v4

    invoke-virtual {p1, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->h:Landroid/widget/Button;

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->j:Lchat/ola/vn/b/x;

    invoke-static {v4}, Lchat/ola/vn/b/x;->a(Lchat/ola/vn/b/x;)Landroid/view/View$OnClickListener;

    move-result-object v4

    invoke-virtual {p1, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->b:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->b:Landroid/widget/TextView;

    invoke-static {}, Lchat/ola/vn/q/a;->a()Lchat/ola/vn/q/a;

    move-result-object v5

    iget-object v6, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object v6, v6, Lchat/ola/vn/entity/j;->e:Ljava/lang/String;

    invoke-static {v4, v5, v6}, Lchat/ola/vn/util/i;->a(Landroid/view/View;Lcom/mg/ola/common/widget/OlaTextView$b;Ljava/lang/String;)Ljava/lang/CharSequence;

    move-result-object v4

    invoke-virtual {p1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->d:Landroid/widget/TextView;

    iget-object v4, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-wide v4, v4, Lchat/ola/vn/entity/j;->h:J

    sub-long v6, v0, v4

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/b;->c()[Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v1

    invoke-virtual {v1}, Lchat/ola/vn/b;->a()[Ljava/lang/String;

    move-result-object v1

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/b;->b()[Ljava/lang/String;

    move-result-object v4

    invoke-static {v6, v7, v0, v1, v4}, Lcom/mg/ola/common/d/i;->a(J[Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->f:Landroid/view/View;

    invoke-virtual {p1, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->g:Landroid/widget/Button;

    invoke-virtual {p1, v3, v3, v3, v3}, Landroid/widget/Button;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->e:Landroid/widget/ImageView;

    invoke-virtual {p1, v3}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object p1, p1, Lchat/ola/vn/entity/j;->f:Ljava/lang/String;

    const-string v0, "3"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->e:Landroid/widget/ImageView;

    const v0, 0x7f08072f

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v0, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object v0, v0, Lchat/ola/vn/entity/j;->b:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lchat/ola/vn/message/g;->c(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_c

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->f:Landroid/view/View;

    invoke-virtual {p1, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->h:Landroid/widget/Button;

    invoke-virtual {p1, v2}, Landroid/widget/Button;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->g:Landroid/widget/Button;

    const v0, 0x7f0f0550

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setText(I)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->g:Landroid/widget/Button;

    const v0, 0x7f080626

    invoke-virtual {p1, v0, v3, v3, v3}, Landroid/widget/Button;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    return-void

    :cond_6
    iget-object p1, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object p1, p1, Lchat/ola/vn/entity/j;->f:Ljava/lang/String;

    const-string v0, "1"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_7

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->e:Landroid/widget/ImageView;

    const v0, 0x7f080733

    :goto_2
    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object p1, p1, Lchat/ola/vn/entity/j;->f:Ljava/lang/String;

    const-string v0, "1.4"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_8

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->e:Landroid/widget/ImageView;

    const v0, 0x7f080732

    goto :goto_2

    :cond_8
    iget-object p1, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object p1, p1, Lchat/ola/vn/entity/j;->f:Ljava/lang/String;

    const-string v0, "3.1"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_9

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->e:Landroid/widget/ImageView;

    const v0, 0x7f080734

    goto :goto_2

    :cond_9
    iget-object p1, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object p1, p1, Lchat/ola/vn/entity/j;->f:Ljava/lang/String;

    const-string v0, "2"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_b

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object p1, p1, Lchat/ola/vn/entity/j;->g:Ljava/lang/String;

    const-string v0, "proposal"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_a

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->f:Landroid/view/View;

    invoke-virtual {p1, v3}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->e:Landroid/widget/ImageView;

    const v0, 0x7f080731

    goto :goto_2

    :cond_a
    iget-object p1, p0, Lchat/ola/vn/b/x$a;->i:Lchat/ola/vn/entity/j;

    iget-object p1, p1, Lchat/ola/vn/entity/j;->g:Ljava/lang/String;

    const-string v0, "divorce"

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_b

    iget-object p1, p0, Lchat/ola/vn/b/x$a;->e:Landroid/widget/ImageView;

    const v0, 0x7f080730

    goto :goto_2

    :cond_b
    iget-object p1, p0, Lchat/ola/vn/b/x$a;->e:Landroid/widget/ImageView;

    invoke-virtual {p1, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    :cond_c
    return-void
.end method
