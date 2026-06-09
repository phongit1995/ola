.class Lchat/ola/vn/entry/b/h$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/h;->b()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/util/List;

.field final synthetic c:Lchat/ola/vn/entry/b/h;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/h;Ljava/lang/String;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/h$1;->c:Lchat/ola/vn/entry/b/h;

    iput-object p2, p0, Lchat/ola/vn/entry/b/h$1;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/entry/b/h$1;->b:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    invoke-virtual {p1}, Landroid/view/View;->isSelected()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/entry/b/h$1;->c:Lchat/ola/vn/entry/b/h;

    invoke-static {v0}, Lchat/ola/vn/entry/b/h;->a(Lchat/ola/vn/entry/b/h;)Landroid/view/View;

    move-result-object v0

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/h$1;->c:Lchat/ola/vn/entry/b/h;

    invoke-static {v0}, Lchat/ola/vn/entry/b/h;->b(Lchat/ola/vn/entry/b/h;)Landroid/widget/ImageView;

    move-result-object v0

    const v1, 0x7f0806ba

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/entry/b/h$1;->a:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/entry/b/h$1;->b:Ljava/util/List;

    if-eqz v0, :cond_2

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/entry/b/h$1;->c:Lchat/ola/vn/entry/b/h;

    invoke-static {v0}, Lchat/ola/vn/entry/b/h;->a(Lchat/ola/vn/entry/b/h;)Landroid/view/View;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/h$1;->c:Lchat/ola/vn/entry/b/h;

    invoke-static {v0}, Lchat/ola/vn/entry/b/h;->c(Lchat/ola/vn/entry/b/h;)V

    iget-object v0, p0, Lchat/ola/vn/entry/b/h$1;->c:Lchat/ola/vn/entry/b/h;

    invoke-static {v0}, Lchat/ola/vn/entry/b/h;->b(Lchat/ola/vn/entry/b/h;)Landroid/widget/ImageView;

    move-result-object v0

    const v1, 0x7f0806b9

    goto :goto_0

    :cond_2
    :goto_1
    invoke-virtual {p1}, Landroid/view/View;->isSelected()Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    invoke-virtual {p1, v0}, Landroid/view/View;->setSelected(Z)V

    return-void
.end method
