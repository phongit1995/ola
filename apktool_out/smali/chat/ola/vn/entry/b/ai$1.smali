.class Lchat/ola/vn/entry/b/ai$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/o;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/ai;->a(Lchat/ola/vn/message/ab;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/message/ab;

.field final synthetic b:Lchat/ola/vn/entry/b/ai;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/ai;Lchat/ola/vn/message/ab;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/ai$1;->b:Lchat/ola/vn/entry/b/ai;

    iput-object p2, p0, Lchat/ola/vn/entry/b/ai$1;->a:Lchat/ola/vn/message/ab;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/entry/b/ai$1;->a:Lchat/ola/vn/message/ab;

    const-string v1, ""

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/ab;->a(Ljava/lang/String;)V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/ai;)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ai$1;->a:Lchat/ola/vn/message/ab;

    invoke-virtual {v0}, Lchat/ola/vn/message/ab;->c()Ljava/lang/String;

    move-result-object v0

    iget-object v1, p1, Lchat/ola/vn/entity/ai;->c:Ljava/lang/String;

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_3

    iget-object v0, p1, Lchat/ola/vn/entity/ai;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/ai$1;->a:Lchat/ola/vn/message/ab;

    iget-object v1, p1, Lchat/ola/vn/entity/ai;->a:Ljava/lang/String;

    :goto_0
    invoke-virtual {v0, v1}, Lchat/ola/vn/message/ab;->a(Ljava/lang/String;)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/ai$1;->a:Lchat/ola/vn/message/ab;

    const-string v1, ""

    goto :goto_0

    :goto_1
    iget-object v0, p1, Lchat/ola/vn/entity/ai;->d:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/ai$1;->a:Lchat/ola/vn/message/ab;

    iget-object p1, p1, Lchat/ola/vn/entity/ai;->d:Ljava/lang/String;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/ab;->n(Ljava/lang/String;)V

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/entry/b/ai$1;->a:Lchat/ola/vn/message/ab;

    invoke-virtual {p1}, Lchat/ola/vn/message/ab;->a()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/entry/b/ai$1;->b:Lchat/ola/vn/entry/b/ai;

    invoke-static {p1}, Lchat/ola/vn/entry/b/ai;->a(Lchat/ola/vn/entry/b/ai;)Landroid/view/View;

    move-result-object p1

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ai$1;->b:Lchat/ola/vn/entry/b/ai;

    invoke-static {p1}, Lchat/ola/vn/entry/b/ai;->b(Lchat/ola/vn/entry/b/ai;)Landroid/widget/TextView;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/ai$1;->a:Lchat/ola/vn/message/ab;

    invoke-virtual {v0}, Lchat/ola/vn/message/ab;->a()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ai$1;->b:Lchat/ola/vn/entry/b/ai;

    invoke-static {p1}, Lchat/ola/vn/entry/b/ai;->c(Lchat/ola/vn/entry/b/ai;)Landroid/widget/TextView;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/entry/b/ai$1;->a:Lchat/ola/vn/message/ab;

    invoke-virtual {v0}, Lchat/ola/vn/message/ab;->C()Ljava/lang/String;

    move-result-object v0

    :goto_2
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    iget-object p1, p0, Lchat/ola/vn/entry/b/ai$1;->b:Lchat/ola/vn/entry/b/ai;

    invoke-static {p1}, Lchat/ola/vn/entry/b/ai;->a(Lchat/ola/vn/entry/b/ai;)Landroid/view/View;

    move-result-object p1

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ai$1;->b:Lchat/ola/vn/entry/b/ai;

    invoke-static {p1}, Lchat/ola/vn/entry/b/ai;->b(Lchat/ola/vn/entry/b/ai;)Landroid/widget/TextView;

    move-result-object p1

    const-string v0, ""

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/entry/b/ai$1;->b:Lchat/ola/vn/entry/b/ai;

    invoke-static {p1}, Lchat/ola/vn/entry/b/ai;->c(Lchat/ola/vn/entry/b/ai;)Landroid/widget/TextView;

    move-result-object p1

    const-string v0, ""
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_3
    return-void
.end method
