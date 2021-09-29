define superset::importdashboards (
    String[1]                                         $resources_local_path        = '',
    String[1]                                         $dashboards_path             = '',
)
{
    exec{ 'superset import dashboards':
      command     => join([
      "${superset::base_dir}/venv/bin/superset import-dashboards",
      "--path ${resources_local_path}/${dashboards_path}",
      "--username ${superset::admin_user}",
    ], ' '),
    cwd         => $superset::base_dir,
    user        => $superset::owner,
    group       => $superset::group,
    path        => '/usr/sbin:/usr/bin:/sbin:/bin',
    environment => [
      "PYTHONPATH=${superset::base_dir}",
      "SUPERSET_CONFIG_PATH=${superset::base_dir}/superset_config.py",
      'FLASK_APP=superset'
    ],
    require     => Vcsrepo[$resources_local_path],
}
