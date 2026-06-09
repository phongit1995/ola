.class Lchat/ola/vn/m/n$12;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnFocusChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/n;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/n;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/n;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/n$12;->a:Lchat/ola/vn/m/n;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFocusChange(Landroid/view/View;Z)V
    .locals 4

    if-eqz p2, :cond_1

    :try_start_0
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->e()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p2

    if-lez p2, :cond_1

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/f;

    new-instance v1, Lchat/ola/vn/entity/x;

    invoke-direct {v1}, Lchat/ola/vn/entity/x;-><init>()V

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "@"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lchat/ola/vn/entity/x;->c:Ljava/lang/String;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lchat/ola/vn/entity/x;->b:Ljava/lang/String;

    const/4 v0, 0x0

    iput-byte v0, v1, Lchat/ola/vn/entity/x;->a:B

    invoke-interface {p2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/n$12;->a:Lchat/ola/vn/m/n;

    invoke-static {p1}, Lchat/ola/vn/m/n;->b(Lchat/ola/vn/m/n;)Lchat/ola/vn/b/q;

    move-result-object p1

    invoke-virtual {p1, p2}, Lchat/ola/vn/b/q;->a(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/m/n$12;->a:Lchat/ola/vn/m/n;

    invoke-static {p1}, Lchat/ola/vn/m/n;->b(Lchat/ola/vn/m/n;)Lchat/ola/vn/b/q;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/b/q;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
