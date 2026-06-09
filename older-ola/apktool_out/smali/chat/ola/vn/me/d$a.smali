.class public Lchat/ola/vn/me/d$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/me/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "a"
.end annotation


# instance fields
.field protected a:Lchat/ola/vn/view/OlaCachedImageView;

.field protected b:Landroid/widget/TextView;

.field protected c:Landroid/widget/TextView;

.field protected d:Landroid/widget/Button;

.field protected e:Landroid/view/View;

.field final synthetic f:Lchat/ola/vn/me/d;

.field private g:Lchat/ola/vn/message/f;


# direct methods
.method protected constructor <init>(Lchat/ola/vn/me/d;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/d$a;->f:Lchat/ola/vn/me/d;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f0903e3

    :try_start_0
    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/view/OlaCachedImageView;

    iput-object p1, p0, Lchat/ola/vn/me/d$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const p1, 0x7f0901b9

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/me/d$a;->b:Landroid/widget/TextView;

    const p1, 0x7f0905f9

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/me/d$a;->c:Landroid/widget/TextView;

    const p1, 0x7f090031

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    iput-object p1, p0, Lchat/ola/vn/me/d$a;->d:Landroid/widget/Button;

    const p1, 0x7f0905fa

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/me/d$a;->e:Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private b()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/d$a;->g:Lchat/ola/vn/message/f;

    iget-boolean v0, v0, Lchat/ola/vn/message/f;->G:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->d:Landroid/widget/Button;

    const v2, 0x7f080128

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->d:Landroid/widget/Button;

    const v2, 0x7f0f0550

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->d:Landroid/widget/Button;

    sget v2, Lchat/ola/vn/f;->C:I

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->d:Landroid/widget/Button;

    const v2, 0x7f080626

    :goto_0
    invoke-virtual {v0, v2, v1, v1, v1}, Landroid/widget/Button;->setCompoundDrawablesWithIntrinsicBounds(IIII)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/d$a;->d:Landroid/widget/Button;

    const v2, 0x7f08011a

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setBackgroundResource(I)V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->d:Landroid/widget/Button;

    const v2, 0x7f0f041e

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setText(I)V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->d:Landroid/widget/Button;

    sget v2, Lchat/ola/vn/f;->z:I

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setTextColor(I)V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->d:Landroid/widget/Button;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const v2, 0x7f08069a

    goto :goto_0

    :catch_0
    return-void
.end method


# virtual methods
.method protected a()V
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/me/d$a;->g:Lchat/ola/vn/message/f;

    const/16 v1, 0x8

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->d:Landroid/widget/Button;

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->c:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const v1, 0x7f0806a5

    invoke-virtual {v0, v1}, Lchat/ola/vn/view/OlaCachedImageView;->setImageResource(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/me/d$a;->f:Lchat/ola/vn/me/d;

    iget-object v0, v0, Lchat/ola/vn/me/d;->b:Landroid/view/View$OnClickListener;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->d:Landroid/widget/Button;

    iget-object v2, p0, Lchat/ola/vn/me/d$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->e:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/me/d$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v0, v2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->d:Landroid/widget/Button;

    iget-object v2, p0, Lchat/ola/vn/me/d$a;->f:Lchat/ola/vn/me/d;

    iget-object v2, v2, Lchat/ola/vn/me/d;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v2}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->e:Landroid/view/View;

    iget-object v2, p0, Lchat/ola/vn/me/d$a;->f:Lchat/ola/vn/me/d;

    iget-object v2, v2, Lchat/ola/vn/me/d;->b:Landroid/view/View$OnClickListener;

    invoke-virtual {v0, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    :cond_1
    invoke-direct {p0}, Lchat/ola/vn/me/d$a;->b()V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    const/4 v2, 0x0

    if-eqz v0, :cond_2

    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v0

    iget-object v3, p0, Lchat/ola/vn/me/d$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v3

    iget-object v4, p0, Lchat/ola/vn/me/d$a;->a:Lchat/ola/vn/view/OlaCachedImageView;

    invoke-virtual {v0, v3, v2, v4}, Lchat/ola/vn/c/t;->b(Ljava/lang/String;ZLchat/ola/vn/view/OlaCachedImageView;)V

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/me/d$a;->b:Landroid/widget/TextView;

    iget-object v3, p0, Lchat/ola/vn/me/d$a;->g:Lchat/ola/vn/message/f;

    invoke-virtual {v3}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v3

    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->g:Lchat/ola/vn/message/f;

    iget-object v0, v0, Lchat/ola/vn/message/f;->q:Ljava/lang/Long;

    if-eqz v0, :cond_3

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->c:Landroid/widget/TextView;

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->c:Landroid/widget/TextView;

    iget-object v1, p0, Lchat/ola/vn/me/d$a;->g:Lchat/ola/vn/message/f;

    iget-object v1, v1, Lchat/ola/vn/message/f;->q:Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/b;->c()[Ljava/lang/String;

    move-result-object v3

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/b;->a()[Ljava/lang/String;

    move-result-object v4

    invoke-static {}, Lchat/ola/vn/b;->d()Lchat/ola/vn/b;

    move-result-object v5

    invoke-virtual {v5}, Lchat/ola/vn/b;->b()[Ljava/lang/String;

    move-result-object v5

    invoke-static {v1, v2, v3, v4, v5}, Lcom/mg/ola/common/d/i;->a(J[Ljava/lang/String;[Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_3
    iget-object v0, p0, Lchat/ola/vn/me/d$a;->c:Landroid/widget/TextView;

    const-string v2, ""

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lchat/ola/vn/me/d$a;->c:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/d$a;->g:Lchat/ola/vn/message/f;

    return-void
.end method
