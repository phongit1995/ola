.class Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->E()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;->a:Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
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
    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;->a:Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->a(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)Lchat/ola/vn/b/a;

    move-result-object p1

    invoke-virtual {p1, p3}, Lchat/ola/vn/b/a;->a(I)Lchat/ola/vn/entity/l;

    move-result-object p1

    iget-boolean p2, p1, Lchat/ola/vn/entity/l;->k:Z

    if-nez p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;->a:Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;

    invoke-static {p2}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->b(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)Lchat/ola/vn/entity/l;

    move-result-object p2

    const/4 p3, 0x0

    iput-boolean p3, p2, Lchat/ola/vn/entity/l;->k:Z

    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;->a:Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;

    invoke-static {p2, p1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->a(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;Lchat/ola/vn/entity/l;)Lchat/ola/vn/entity/l;

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;->a:Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->b(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)Lchat/ola/vn/entity/l;

    move-result-object p1

    const/4 p2, 0x1

    iput-boolean p2, p1, Lchat/ola/vn/entity/l;->k:Z

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;->a:Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->c(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)Lchat/ola/vn/cloud/b;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/cloud/b;->a()V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;->a:Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->c(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)Lchat/ola/vn/cloud/b;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/cloud/b;->notifyDataSetChanged()V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;->a:Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->a(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;Ljava/lang/String;)Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;->a:Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->d(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)Landroid/widget/TextView;

    move-result-object p1

    iget-object p2, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;->a:Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;

    invoke-static {p2}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->b(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)Lchat/ola/vn/entity/l;

    move-result-object p2

    iget-object p2, p2, Lchat/ola/vn/entity/l;->a:Ljava/lang/String;

    invoke-virtual {p1, p2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;->a:Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;

    invoke-static {p1}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->a(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;)Lchat/ola/vn/b/a;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/b/a;->notifyDataSetChanged()V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;->a:Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;

    invoke-virtual {p1, p3}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->a_(I)V

    iget-object p1, p0, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity$1;->a:Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;

    invoke-static {p1, p3}, Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;->a(Lchat/ola/vn/cloud/OlaCloudPhotoChooserActivity;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
