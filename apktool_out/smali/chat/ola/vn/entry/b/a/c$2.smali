.class Lchat/ola/vn/entry/b/a/c$2;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/c;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/a/c;->a(Lchat/ola/vn/entry/b/ab;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/ab;

.field final synthetic b:Lchat/ola/vn/entry/b/a/c;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/a/c;Lchat/ola/vn/entry/b/ab;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/c$2;->a:Lchat/ola/vn/entry/b/ab;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(J)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    new-instance p2, Lchat/ola/vn/entity/f;

    invoke-direct {p2}, Lchat/ola/vn/entity/f;-><init>()V

    iput-object p2, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    const/4 p2, 0x1

    iput-boolean p2, p1, Lchat/ola/vn/entity/f;->a:Z

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->a:Lchat/ola/vn/entry/b/ab;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b/ab;->g()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(JLchat/ola/vn/entity/f;)V
    .locals 5

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v0, v0, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->v()J

    move-result-wide v0

    cmp-long v2, p1, v0

    if-nez v2, :cond_7

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->a(Lchat/ola/vn/entry/b/a/c;)Landroid/view/View;

    move-result-object p1

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->b(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/ProgressBar;

    move-result-object p1

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iput-object p3, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->c:Landroid/view/View;

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->c(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    iget-object v1, p3, Lchat/ola/vn/entity/f;->l:Ljava/lang/String;

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->r:I

    const/4 v1, 0x1

    if-lez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->r:I

    if-le p1, v1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->d(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget v3, v3, Lchat/ola/vn/entity/f;->r:I

    int-to-long v3, v3

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v3, 0x7f0f0538

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_0
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->d(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget v3, v3, Lchat/ola/vn/entity/f;->r:I

    int-to-long v3, v3

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v3, 0x7f0f0539

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1}, Lchat/ola/vn/entity/f;->a()Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->d(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    sget v2, Lchat/ola/vn/f;->H:I

    :goto_2
    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_3

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->d(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    sget v2, Lchat/ola/vn/f;->z:I

    goto :goto_2

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->d(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    sget v2, Lchat/ola/vn/f;->z:I

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->d(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    const v2, 0x7f0f0536

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setText(I)V

    :goto_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->t:I

    if-lez p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->e(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->t:I

    if-le p1, v1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->e(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget v3, v3, Lchat/ola/vn/entity/f;->t:I

    int-to-long v3, v3

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v3, 0x7f0f0487

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_4
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_5

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->e(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object v3, v3, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object v3, v3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget v3, v3, Lchat/ola/vn/entity/f;->t:I

    int-to-long v3, v3

    invoke-static {v3, v4}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v3, 0x7f0f0486

    invoke-static {v3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_4

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->e(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :goto_5
    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->f(Lchat/ola/vn/entry/b/a/c;)[Lchat/ola/vn/view/OlaCachedImageView;

    move-result-object p1

    aget-object p1, p1, p2

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->f(Lchat/ola/vn/entry/b/a/c;)[Lchat/ola/vn/view/OlaCachedImageView;

    move-result-object p1

    aget-object p1, p1, v1

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->f(Lchat/ola/vn/entry/b/a/c;)[Lchat/ola/vn/view/OlaCachedImageView;

    move-result-object p1

    const/4 v1, 0x2

    aget-object p1, p1, v1

    invoke-virtual {p1, v0}, Lchat/ola/vn/view/OlaCachedImageView;->setVisibility(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p1}, Lchat/ola/vn/entity/g;->k()S

    move-result p1

    const/16 v0, 0xb

    if-ne p1, v0, :cond_6

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->t:I

    if-nez p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->e(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->e(Lchat/ola/vn/entry/b/a/c;)Landroid/widget/TextView;

    move-result-object p1

    const p2, 0x7f0f0436

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(I)V

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {p3}, Lchat/ola/vn/entity/f;->c()S

    move-result p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/g;->c(S)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget p2, p3, Lchat/ola/vn/entity/f;->r:I

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/g;->a(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget p2, p3, Lchat/ola/vn/entity/f;->s:I

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/g;->c(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object p2, p3, Lchat/ola/vn/entity/f;->i:[Ljava/lang/String;

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/g;->a([Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget p2, p3, Lchat/ola/vn/entity/f;->t:I

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/g;->b(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->g(Lchat/ola/vn/entry/b/a/c;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->h(Lchat/ola/vn/entry/b/a/c;)V

    :cond_6
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->i(Lchat/ola/vn/entry/b/a/c;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->c:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p2, p2, Lchat/ola/vn/entry/b/a/c;->b:Lchat/ola/vn/entry/b;

    iget-object p2, p2, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1, p2}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/c;->c:Landroid/view/View;

    iget-object p2, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    iget-object p2, p2, Lchat/ola/vn/entry/b/a/c;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, p2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/c$2;->b:Lchat/ola/vn/entry/b/a/c;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/c;->j(Lchat/ola/vn/entry/b/a/c;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_7
    return-void
.end method
