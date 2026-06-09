.class Lchat/ola/vn/b/af$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/af;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field a:Landroid/widget/ImageView;

.field b:Landroid/widget/TextView;

.field c:Landroid/widget/TextView;

.field d:Landroid/view/View;

.field final synthetic e:Lchat/ola/vn/b/af;


# direct methods
.method constructor <init>(Lchat/ola/vn/b/af;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/af$a;->e:Lchat/ola/vn/b/af;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lchat/ola/vn/b/af$a;->d:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/b/af$a;->d:Landroid/view/View;

    const p2, 0x7f0902a5

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/b/af$a;->a:Landroid/widget/ImageView;

    iget-object p1, p0, Lchat/ola/vn/b/af$a;->d:Landroid/view/View;

    const p2, 0x7f09052a

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/af$a;->b:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/b/af$a;->d:Landroid/view/View;

    const p2, 0x7f090529

    invoke-virtual {p1, p2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/af$a;->c:Landroid/widget/TextView;

    iget-object p1, p0, Lchat/ola/vn/b/af$a;->d:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/s;)V
    .locals 6

    iget-object v0, p0, Lchat/ola/vn/b/af$a;->b:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->d()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    new-instance v0, Landroid/text/SpannableStringBuilder;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lchat/ola/vn/b/af$a;->e:Lchat/ola/vn/b/af;

    invoke-static {v2}, Lchat/ola/vn/b/af;->a(Lchat/ola/vn/b/af;)Landroid/content/Context;

    move-result-object v2

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->a()J

    move-result-wide v4

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    aput-object v4, v3, v5

    const v4, 0x7f0f033c

    invoke-virtual {v2, v4, v3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ") "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/text/SpannableStringBuilder;-><init>(Ljava/lang/CharSequence;)V

    sget v1, Lchat/ola/vn/f;->z:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0}, Landroid/text/SpannableStringBuilder;->length()I

    move-result v2

    const/16 v3, 0x21

    invoke-virtual {v0, v1, v5, v2, v3}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    iget-object v1, p0, Lchat/ola/vn/b/af$a;->c:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->f()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/b/af$a;->c:Landroid/widget/TextView;

    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->f()Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->append(Ljava/lang/CharSequence;)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/af$a;->c:Landroid/widget/TextView;

    const-string v1, " "

    goto :goto_0

    :goto_1
    invoke-virtual {p1}, Lchat/ola/vn/entity/s;->c()J

    move-result-wide v0

    const-wide/16 v2, -0x1

    cmp-long p1, v0, v2

    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/b/af$a;->a:Landroid/widget/ImageView;

    invoke-virtual {p1, v5}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/b/af$a;->a:Landroid/widget/ImageView;

    const v0, 0x7f080711

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/b/af$a;->a:Landroid/widget/ImageView;

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    return-void
.end method
