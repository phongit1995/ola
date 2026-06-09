.class Lchat/ola/vn/entry/b/a/a$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/c;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/a/a;->a(Lchat/ola/vn/entry/b/ab;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/ab;

.field final synthetic b:Lchat/ola/vn/entry/b/a/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/a/a;Lchat/ola/vn/entry/b/ab;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iput-object p2, p0, Lchat/ola/vn/entry/b/a/a$1;->a:Lchat/ola/vn/entry/b/ab;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(J)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    new-instance p2, Lchat/ola/vn/entity/f;

    invoke-direct {p2}, Lchat/ola/vn/entity/f;-><init>()V

    iput-object p2, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    const/4 p2, 0x1

    iput-boolean p2, p1, Lchat/ola/vn/entity/f;->a:Z

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->a:Lchat/ola/vn/entry/b/ab;

    invoke-virtual {p1}, Lchat/ola/vn/entry/b/ab;->g()V

    return-void
.end method

.method public a(JLchat/ola/vn/entity/f;)V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object v0, v0, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v0, v0, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    invoke-virtual {v0}, Lchat/ola/vn/entity/g;->x()Lchat/ola/vn/entity/h;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/entity/h;->a()J

    move-result-wide v0

    cmp-long v2, p1, v0

    if-nez v2, :cond_b

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->a(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/ProgressBar;

    move-result-object p1

    const/16 p2, 0x8

    invoke-virtual {p1, p2}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iput-object p3, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p3, Lchat/ola/vn/entity/f;->f:Ljava/lang/String;

    iget-object v0, p3, Lchat/ola/vn/entity/f;->f:Ljava/lang/String;

    const-string v1, "rss"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const p1, 0x7f0f00f8

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_0
    iget-object v0, p3, Lchat/ola/vn/entity/f;->f:Ljava/lang/String;

    const-string v2, "kho"

    invoke-static {v0, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const p1, 0x7f0f00f2

    invoke-static {p1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_1
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v2, p3, Lchat/ola/vn/entity/f;->f:Ljava/lang/String;

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object p1

    :cond_2
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {v0}, Lchat/ola/vn/entry/b/a/a;->b(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->c(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    iget-object p3, p3, Lchat/ola/vn/entity/f;->d:Ljava/lang/CharSequence;

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->c:Landroid/view/View;

    iget-object p3, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p3, p3, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p3, p3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1, p3}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->c:Landroid/view/View;

    iget-object p3, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p3, p3, Lchat/ola/vn/entry/b/a/a;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, p3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->d(Lchat/ola/vn/entry/b/a/a;)Landroid/view/View;

    move-result-object p1

    iget-object p3, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p3, p3, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p3, p3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1, p3}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->d(Lchat/ola/vn/entry/b/a/a;)Landroid/view/View;

    move-result-object p1

    iget-object p3, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p3, p3, Lchat/ola/vn/entry/b/a/a;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, p3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->e(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    iget-object p3, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p3, p3, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p3, p3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setTag(Ljava/lang/Object;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->e(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    iget-object p3, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p3, p3, Lchat/ola/vn/entry/b/a/a;->d:Landroid/view/View$OnClickListener;

    invoke-virtual {p1, p3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->f(Lchat/ola/vn/entry/b/a/a;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p1, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->g(Lchat/ola/vn/entry/b/a/a;)V

    goto :goto_1

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p1, Lchat/ola/vn/entity/f;->o:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->h(Lchat/ola/vn/entry/b/a/a;)V

    goto :goto_1

    :cond_4
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget-object p1, p1, Lchat/ola/vn/entity/f;->n:Ljava/lang/String;

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->i(Lchat/ola/vn/entry/b/a/a;)V

    goto :goto_1

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->d(Lchat/ola/vn/entry/b/a/a;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->e(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->r:I

    const/4 p3, 0x1

    if-lez p1, :cond_8

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    invoke-virtual {p1}, Lchat/ola/vn/entity/f;->a()Z

    move-result p1

    if-eqz p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->e(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    sget v0, Lchat/ola/vn/f;->H:I

    :goto_2
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    goto :goto_3

    :cond_6
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->e(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    sget v0, Lchat/ola/vn/f;->z:I

    goto :goto_2

    :goto_3
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->r:I

    if-le p1, p3, :cond_7

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->e(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object v2, v2, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget v2, v2, Lchat/ola/vn/entity/f;->r:I

    int-to-long v2, v2

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f0538

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_4
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_5

    :cond_7
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->e(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object v2, v2, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object v2, v2, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget v2, v2, Lchat/ola/vn/entity/f;->r:I

    int-to-long v2, v2

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f0539

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_4

    :cond_8
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->e(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    sget v0, Lchat/ola/vn/f;->z:I

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->e(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    const v0, 0x7f0f0536

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(I)V

    :goto_5
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->t:I

    if-lez p1, :cond_a

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->j(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p1, p1, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p1, p1, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p1, p1, Lchat/ola/vn/entity/f;->t:I

    if-le p1, p3, :cond_9

    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->j(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object p3, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p3, p3, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p3, p3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p3, p3, Lchat/ola/vn/entity/f;->t:I

    int-to-long v0, p3

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, " "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const p3, 0x7f0f0487

    invoke-static {p3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_6
    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_9
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->j(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object p3, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    iget-object p3, p3, Lchat/ola/vn/entry/b/a/a;->b:Lchat/ola/vn/entry/b;

    iget-object p3, p3, Lchat/ola/vn/entry/b;->a:Lchat/ola/vn/entity/f;

    iget p3, p3, Lchat/ola/vn/entity/f;->t:I

    int-to-long v0, p3

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, " "

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const p3, 0x7f0f0486

    invoke-static {p3}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_6

    :cond_a
    iget-object p1, p0, Lchat/ola/vn/entry/b/a/a$1;->b:Lchat/ola/vn/entry/b/a/a;

    invoke-static {p1}, Lchat/ola/vn/entry/b/a/a;->j(Lchat/ola/vn/entry/b/a/a;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setVisibility(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_b
    return-void
.end method
