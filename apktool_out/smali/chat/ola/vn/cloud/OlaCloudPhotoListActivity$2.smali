.class Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->H()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    iput-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;->a:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    const p3, 0x7f0f05b2

    invoke-virtual {p2, p3}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;)Lchat/ola/vn/cloud/b;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/cloud/b;->c()Ljava/util/List;

    move-result-object p1

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p3

    if-eqz p3, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/entity/i;

    invoke-virtual {p3}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p4

    invoke-static {p4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p4

    if-nez p4, :cond_0

    invoke-virtual {p3}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p3

    invoke-interface {p2, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    const/4 p3, 0x0

    invoke-static {p1, p3, p3, p2}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;)V

    return-void

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    const p3, 0x7f0f0491

    invoke-virtual {p2, p3}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const/4 p3, 0x0

    const/4 p4, 0x1

    if-eqz p2, :cond_5

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;)Lchat/ola/vn/cloud/b;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/cloud/b;->c()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_8

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p2

    if-lez p2, :cond_8

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p5, "##"

    invoke-virtual {p2, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/entity/i;

    invoke-virtual {p3}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, "#"

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p3

    :goto_1
    if-ge p4, p3, :cond_4

    invoke-interface {p1, p4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p5

    check-cast p5, Lchat/ola/vn/entity/i;

    invoke-virtual {p5}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, " ##"

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p5}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "#"

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    :cond_3
    add-int/lit8 p4, p4, 0x1

    goto :goto_1

    :cond_4
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_8

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    invoke-static {p1, p2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_5
    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    const p5, 0x7f0f0493

    invoke-virtual {p2, p5}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_8

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;->a(Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;)Lchat/ola/vn/cloud/b;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/cloud/b;->c()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_8

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p2

    if-lez p2, :cond_8

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p5, "##"

    invoke-virtual {p2, p5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Lchat/ola/vn/entity/i;

    invoke-virtual {p3}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, "#"

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p3

    :goto_2
    if-ge p4, p3, :cond_7

    invoke-interface {p1, p4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p5

    check-cast p5, Lchat/ola/vn/entity/i;

    invoke-virtual {p5}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_6

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, " ##"

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p5}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p2, "#"

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    :cond_6
    add-int/lit8 p4, p4, 0x1

    goto :goto_2

    :cond_7
    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_8

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    invoke-static {p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p1

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, " "

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoListActivity$2;->b:Lchat/ola/vn/cloud/OlaCloudPhotoListActivity;

    invoke-static {p2, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_8
    return-void
.end method
