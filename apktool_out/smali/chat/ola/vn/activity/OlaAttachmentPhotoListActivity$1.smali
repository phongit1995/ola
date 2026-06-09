.class Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->I()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0xf

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Z)V

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    const-string p2, "null"

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Ljava/lang/String;)Ljava/lang/String;

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 7

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Z)V

    array-length v0, p1

    const/4 v1, 0x1

    if-le v0, v1, :cond_a

    aget-object v0, p1, v1

    check-cast v0, Ljava/util/List;

    if-eqz v0, :cond_0

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    if-nez v2, :cond_1

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {v2}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->c(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    return-void

    :cond_1
    new-instance v2, Ljava/util/ArrayList;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    invoke-direct {v2, v3}, Ljava/util/ArrayList;-><init>(I)V

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_2
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    const/4 v4, 0x2

    if-eqz v3, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/i;

    invoke-virtual {v3}, Lchat/ola/vn/entity/i;->f()S

    move-result v5

    if-eq v5, v1, :cond_3

    invoke-static {}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->F()Z

    move-result v5

    if-eqz v5, :cond_2

    invoke-virtual {v3}, Lchat/ola/vn/entity/i;->f()S

    move-result v5

    if-ne v5, v4, :cond_2

    :cond_3
    new-instance v4, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;

    iget-object v5, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    const/4 v6, 0x0

    invoke-direct {v4, v5, v6}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;-><init>(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;)V

    invoke-virtual {v3}, Lchat/ola/vn/entity/i;->f()S

    move-result v5

    iput-short v5, v4, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->c:S

    invoke-virtual {v3}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v3

    iput-object v3, v4, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$e;->d:Ljava/lang/String;

    invoke-interface {v2, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_4
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    invoke-static {v0, v1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Ljava/util/List;)Ljava/util/List;

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->c(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_6

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->clear()V

    :cond_6
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_7

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_7
    array-length v0, p1

    if-le v0, v4, :cond_8

    iget-object v0, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    aget-object p1, p1, v4

    check-cast p1, Ljava/lang/String;

    invoke-static {v0, p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Ljava/lang/String;)Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->c(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_9

    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    const-string v0, "null"

    :goto_1
    invoke-static {p1, v0}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->a(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;Ljava/lang/String;)Ljava/lang/String;

    goto :goto_2

    :cond_8
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    const-string v0, "null"

    goto :goto_1

    :cond_9
    :goto_2
    iget-object p1, p0, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$1;->a:Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;->b(Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity;)Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/activity/OlaAttachmentPhotoListActivity$d;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_a
    return-void
.end method
