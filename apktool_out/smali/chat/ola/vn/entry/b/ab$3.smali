.class Lchat/ola/vn/entry/b/ab$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/entry/b/ab;->i()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entry/b/ab;


# direct methods
.method constructor <init>(Lchat/ola/vn/entry/b/ab;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/ab$3;->a:Lchat/ola/vn/entry/b/ab;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/entry/b/ab$3;->a:Lchat/ola/vn/entry/b/ab;

    iget-object v1, v1, Lchat/ola/vn/entry/b/ab;->b:Lchat/ola/vn/entry/b;

    iget-object v1, v1, Lchat/ola/vn/entry/b;->b:Lchat/ola/vn/entity/g;

    iget-object v1, v1, Lchat/ola/vn/entity/g;->e:Lchat/ola/vn/entity/o;

    invoke-virtual {v1}, Lchat/ola/vn/entity/o;->c()Ljava/util/List;

    move-result-object v1

    const/4 v2, 0x0

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->g()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, p1}, Lchat/ola/vn/util/b;->a(Landroid/content/Context;Ljava/lang/String;Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
