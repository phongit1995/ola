.class Lchat/ola/vn/m/o$1;
.super Ljava/lang/Object;

# interfaces
.implements Lit/sephiroth/android/library/widget/EnhancedListView$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/o;->c()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/o;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/o;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/o$1;->a:Lchat/ola/vn/m/o;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lit/sephiroth/android/library/widget/EnhancedListView;I)Lit/sephiroth/android/library/widget/EnhancedListView$f;
    .locals 3

    :try_start_0
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/g;->c(I)Lchat/ola/vn/message/f;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 p2, 0x0

    :try_start_1
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->F()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    move p2, v0

    :catch_0
    :try_start_2
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result v0

    const/4 v1, 0x7

    if-ne v0, v1, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->F()Ljava/util/List;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/message/f;

    sget-object v2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v2, v1}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->l()Z

    move-result v0

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/g;->a(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;

    goto :goto_1

    :cond_1
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p1}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;

    :cond_2
    :goto_1
    new-instance v0, Lchat/ola/vn/m/o$1$1;

    invoke-direct {v0, p0, p1, p2}, Lchat/ola/vn/m/o$1$1;-><init>(Lchat/ola/vn/m/o$1;Lchat/ola/vn/message/f;I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    return-object v0

    :catch_1
    const/4 p1, 0x0

    return-object p1
.end method
