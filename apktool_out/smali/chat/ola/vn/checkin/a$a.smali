.class Lchat/ola/vn/checkin/a$a;
.super Landroid/widget/Filter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/checkin/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/checkin/a;


# direct methods
.method private constructor <init>(Lchat/ola/vn/checkin/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/checkin/a$a;->a:Lchat/ola/vn/checkin/a;

    invoke-direct {p0}, Landroid/widget/Filter;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lchat/ola/vn/checkin/a;Lchat/ola/vn/checkin/a$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lchat/ola/vn/checkin/a$a;-><init>(Lchat/ola/vn/checkin/a;)V

    return-void
.end method


# virtual methods
.method protected performFiltering(Ljava/lang/CharSequence;)Landroid/widget/Filter$FilterResults;
    .locals 4

    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    :goto_0
    :try_start_0
    iget-object v2, p0, Lchat/ola/vn/checkin/a$a;->a:Lchat/ola/vn/checkin/a;

    invoke-static {v2}, Lchat/ola/vn/checkin/a;->a(Lchat/ola/vn/checkin/a;)Ljava/util/List;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_1

    invoke-interface {p1}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p0, Lchat/ola/vn/checkin/a$a;->a:Lchat/ola/vn/checkin/a;

    invoke-static {v3}, Lchat/ola/vn/checkin/a;->a(Lchat/ola/vn/checkin/a;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-virtual {v3}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->b()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->h(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    new-instance v2, Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-direct {v2}, Lchat/ola/vn/entity/OlaCheckInItemEntity;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/checkin/a$a;->a:Lchat/ola/vn/checkin/a;

    invoke-static {v3}, Lchat/ola/vn/checkin/a;->a(Lchat/ola/vn/checkin/a;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/OlaCheckInItemEntity;

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/OlaCheckInItemEntity;->a(Lchat/ola/vn/entity/OlaCheckInItemEntity;)V

    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    new-instance p1, Landroid/widget/Filter$FilterResults;

    invoke-direct {p1}, Landroid/widget/Filter$FilterResults;-><init>()V

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v1

    iput v1, p1, Landroid/widget/Filter$FilterResults;->count:I

    iput-object v0, p1, Landroid/widget/Filter$FilterResults;->values:Ljava/lang/Object;

    return-object p1
.end method

.method protected publishResults(Ljava/lang/CharSequence;Landroid/widget/Filter$FilterResults;)V
    .locals 1

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/checkin/a$a;->a:Lchat/ola/vn/checkin/a;

    new-instance v0, Ljava/util/ArrayList;

    iget-object p2, p2, Landroid/widget/Filter$FilterResults;->values:Ljava/lang/Object;

    check-cast p2, Ljava/util/List;

    invoke-direct {v0, p2}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    invoke-static {p1, v0}, Lchat/ola/vn/checkin/a;->a(Lchat/ola/vn/checkin/a;Ljava/util/List;)Ljava/util/List;

    iget-object p1, p0, Lchat/ola/vn/checkin/a$a;->a:Lchat/ola/vn/checkin/a;

    invoke-virtual {p1}, Lchat/ola/vn/checkin/a;->notifyDataSetChanged()V

    :cond_0
    return-void
.end method
